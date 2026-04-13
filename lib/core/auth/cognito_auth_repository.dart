import 'dart:async';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import '../config/env.dart';
import 'auth_repository.dart';
import 'auth_user.dart';

class CognitoAuthException implements Exception {
  final String message;
  CognitoAuthException(this.message);

  @override
  String toString() => message;
}

class CognitoAuthRepository implements AuthRepository {
  late final CognitoUserPool _userPool;
  final _authStateController = StreamController<AuthUser?>.broadcast();
  CognitoUser? _cognitoUser;
  CognitoUserSession? _session;

  CognitoAuthRepository() {
    _userPool = CognitoUserPool(
      Env.cognitoUserPoolId,
      Env.cognitoClientId,
    );
    // Try to restore previous session on init
    _tryRestoreSession();
  }

  Future<void> _tryRestoreSession() async {
    // On app restart, check if there's a cached session
    // This is handled by the Cognito SDK storage
  }

  @override
  Stream<AuthUser?> get authStateChanges => _authStateController.stream;

  String _mapCognitoError(dynamic error) {
    final msg = error.toString().toLowerCase();
    if (msg.contains('user does not exist') || msg.contains('usernotfoundexception')) {
      return 'No account found with that email';
    }
    if (msg.contains('incorrect username or password') || msg.contains('notauthorizedexception')) {
      return 'Incorrect email or password';
    }
    if (msg.contains('user is not confirmed') || msg.contains('usernotconfirmedexception')) {
      return 'Please verify your email first';
    }
    if (msg.contains('username exists') || msg.contains('usernameexistsexception')) {
      return 'An account with this email already exists';
    }
    if (msg.contains('invalid parameter') || msg.contains('invalidparameterexception')) {
      return 'Please check your input and try again';
    }
    if (msg.contains('password') && msg.contains('policy')) {
      return 'Password must be at least 8 characters with uppercase, lowercase, and numbers';
    }
    if (msg.contains('code mismatch') || msg.contains('codemismatchexception')) {
      return 'Invalid verification code';
    }
    if (msg.contains('expired') || msg.contains('expiredcodeexception')) {
      return 'Verification code has expired. Please request a new one';
    }
    if (msg.contains('limit exceeded') || msg.contains('limitexceededexception')) {
      return 'Too many attempts. Please wait and try again';
    }
    if (msg.contains('network') || msg.contains('socketexception')) {
      return 'No internet connection. Please check your network';
    }
    // Show actual error in debug for troubleshooting
    if (msg.length > 10) return error.toString();
    return 'Something went wrong. Please try again';
  }

  AuthUser _mapCognitoUser(CognitoUser cognitoUser, List<CognitoUserAttribute>? attributes) {
    final email = attributes
            ?.firstWhere((a) => a.name == 'email',
                orElse: () => CognitoUserAttribute(name: 'email', value: ''))
            .value ??
        '';
    final phone = attributes
        ?.firstWhere((a) => a.name == 'phone_number',
            orElse: () => CognitoUserAttribute(name: 'phone_number'))
        .value;
    final role = attributes
            ?.firstWhere((a) => a.name == 'custom:role',
                orElse: () => CognitoUserAttribute(name: 'custom:role', value: 'customer'))
            .value ??
        'customer';
    final referredBy = attributes
        ?.firstWhere((a) => a.name == 'custom:referredBy',
            orElse: () => CognitoUserAttribute(name: 'custom:referredBy'))
        .value;
    final onboardingComplete = attributes
            ?.firstWhere((a) => a.name == 'custom:onboardingComplete',
                orElse: () => CognitoUserAttribute(name: 'custom:onboardingComplete', value: 'false'))
            .value ==
        'true';

    return AuthUser(
      id: cognitoUser.username ?? '',
      email: email,
      phone: phone,
      role: role == 'partner' ? UserRole.partner : UserRole.customer,
      referredBy: referredBy,
      onboardingComplete: onboardingComplete,
    );
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _cognitoUser = CognitoUser(email, _userPool);
      final authDetails = AuthenticationDetails(
        username: email,
        password: password,
      );

      _session = await _cognitoUser!.authenticateUser(authDetails);

      if (_session == null || !_session!.isValid()) {
        throw CognitoAuthException('Authentication failed. Please try again');
      }

      final attributes = await _cognitoUser!.getUserAttributes();
      final user = _mapCognitoUser(_cognitoUser!, attributes);
      _authStateController.add(user);
      return user;
    } on CognitoUserNewPasswordRequiredException {
      throw CognitoAuthException('You need to set a new password');
    } on CognitoUserMfaRequiredException {
      throw CognitoAuthException('MFA verification required');
    } on CognitoUserCustomChallengeException {
      throw CognitoAuthException('Custom challenge required');
    } on CognitoUserConfirmationNecessaryException {
      throw CognitoAuthException('Please verify your email first');
    } on CognitoClientException catch (e) {
      throw CognitoAuthException(_mapCognitoError(e));
    } catch (e) {
      throw CognitoAuthException(_mapCognitoError(e));
    }
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    throw CognitoAuthException('Google sign-in is not available yet');
  }

  @override
  Future<AuthUser> signInWithApple() async {
    throw CognitoAuthException('Apple sign-in is not available yet');
  }

  @override
  Future<void> signInWithPhone({required String phoneNumber}) async {
    throw CognitoAuthException('Phone sign-in is not available yet');
  }

  @override
  Future<AuthUser> confirmPhoneSignIn({required String code}) async {
    throw CognitoAuthException('Phone sign-in is not available yet');
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
    required UserRole role,
    String? referralCode,
  }) async {
    try {
      // Only include email as required attribute
      // Custom attributes are optional — only add if they exist in the pool
      final userAttributes = [
        AttributeArg(name: 'email', value: email),
      ];

      // Try with custom attributes first, fall back to email-only
      CognitoUserPoolData result;
      try {
        result = await _userPool.signUp(
          email,
          password,
          userAttributes: [
            ...userAttributes,
            AttributeArg(name: 'custom:role', value: role == UserRole.partner ? 'partner' : 'customer'),
            if (referralCode != null && referralCode.isNotEmpty)
              AttributeArg(name: 'custom:referredBy', value: referralCode),
          ],
        );
      } catch (_) {
        // Custom attributes don't exist in pool — sign up with email only
        result = await _userPool.signUp(
          email,
          password,
          userAttributes: userAttributes,
        );
      }

      return AuthUser(
        id: result.userSub ?? '',
        email: email,
        role: role,
        referredBy: referralCode,
        onboardingComplete: false,
      );
    } on CognitoClientException catch (e) {
      throw CognitoAuthException(_mapCognitoError(e));
    } catch (e) {
      if (e is CognitoAuthException) rethrow;
      throw CognitoAuthException(_mapCognitoError(e));
    }
  }

  @override
  Future<void> confirmSignUp({
    required String email,
    required String code,
  }) async {
    try {
      _cognitoUser = CognitoUser(email, _userPool);
      final result = await _cognitoUser!.confirmRegistration(code);
      if (result != true) {
        throw CognitoAuthException('Verification failed. Please try again');
      }
    } on CognitoClientException catch (e) {
      throw CognitoAuthException(_mapCognitoError(e));
    } catch (e) {
      if (e is CognitoAuthException) rethrow;
      throw CognitoAuthException(_mapCognitoError(e));
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      _cognitoUser = CognitoUser(email, _userPool);
      await _cognitoUser!.forgotPassword();
    } on CognitoClientException catch (e) {
      throw CognitoAuthException(_mapCognitoError(e));
    } catch (e) {
      if (e is CognitoAuthException) rethrow;
      throw CognitoAuthException(_mapCognitoError(e));
    }
  }

  @override
  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      _cognitoUser = CognitoUser(email, _userPool);
      final result = await _cognitoUser!.confirmPassword(code, newPassword);
      if (result != true) {
        throw CognitoAuthException('Password reset failed. Please try again');
      }
    } on CognitoClientException catch (e) {
      throw CognitoAuthException(_mapCognitoError(e));
    } catch (e) {
      if (e is CognitoAuthException) rethrow;
      throw CognitoAuthException(_mapCognitoError(e));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (_cognitoUser != null) {
        await _cognitoUser!.signOut();
      }
    } catch (_) {
      // Sign out locally even if remote fails
    }
    _cognitoUser = null;
    _session = null;
    _authStateController.add(null);
  }
}
