import 'dart:async';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import '../config/env.dart';
import 'auth_repository.dart';
import 'auth_user.dart';

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
  }

  @override
  Stream<AuthUser?> get authStateChanges => _authStateController.stream;

  AuthUser _mapCognitoUser(CognitoUser cognitoUser, List<CognitoUserAttribute>? attributes) {
    final email = attributes
            ?.firstWhere((a) => a.name == 'email', orElse: () => CognitoUserAttribute(name: 'email', value: ''))
            .value ??
        '';
    final phone = attributes
        ?.firstWhere((a) => a.name == 'phone_number', orElse: () => CognitoUserAttribute(name: 'phone_number'))
        .value;
    final role = attributes
            ?.firstWhere((a) => a.name == 'custom:role', orElse: () => CognitoUserAttribute(name: 'custom:role', value: 'customer'))
            .value ??
        'customer';
    final referredBy = attributes
        ?.firstWhere((a) => a.name == 'custom:referredBy', orElse: () => CognitoUserAttribute(name: 'custom:referredBy'))
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
    _cognitoUser = CognitoUser(email, _userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );

    _session = await _cognitoUser!.authenticateUser(authDetails);
    final attributes = await _cognitoUser!.getUserAttributes();
    final user = _mapCognitoUser(_cognitoUser!, attributes);
    _authStateController.add(user);
    return user;
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    // Google Sign-In requires federated identity setup
    // For now, throw unimplemented
    throw UnimplementedError('Google sign-in requires federated identity pool configuration');
  }

  @override
  Future<AuthUser> signInWithApple() async {
    throw UnimplementedError('Apple sign-in requires federated identity pool configuration');
  }

  @override
  Future<void> signInWithPhone({required String phoneNumber}) async {
    _cognitoUser = CognitoUser(phoneNumber, _userPool);
    // Initiate custom auth flow for phone
    // This depends on your Cognito Lambda triggers
    throw UnimplementedError('Phone sign-in requires custom auth Lambda trigger');
  }

  @override
  Future<AuthUser> confirmPhoneSignIn({required String code}) async {
    throw UnimplementedError('Phone sign-in requires custom auth Lambda trigger');
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
    required UserRole role,
    String? referralCode,
  }) async {
    final userAttributes = [
      AttributeArg(name: 'email', value: email),
      AttributeArg(name: 'custom:role', value: role == UserRole.partner ? 'partner' : 'customer'),
      if (referralCode != null) AttributeArg(name: 'custom:referredBy', value: referralCode),
      AttributeArg(name: 'custom:onboardingComplete', value: 'false'),
    ];

    await _userPool.signUp(email, password, userAttributes: userAttributes);

    // User needs to confirm sign up with OTP code
    // Return a preliminary user object
    return AuthUser(
      id: '',
      email: email,
      role: role,
      referredBy: referralCode,
      onboardingComplete: false,
    );
  }

  @override
  Future<void> confirmSignUp({
    required String email,
    required String code,
  }) async {
    _cognitoUser = CognitoUser(email, _userPool);
    final result = await _cognitoUser!.confirmRegistration(code);
    if (result != true) {
      throw Exception('Confirmation failed');
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    _cognitoUser = CognitoUser(email, _userPool);
    await _cognitoUser!.forgotPassword();
  }

  @override
  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    _cognitoUser = CognitoUser(email, _userPool);
    final result = await _cognitoUser!.confirmPassword(code, newPassword);
    if (result != true) {
      throw Exception('Password reset failed');
    }
  }

  @override
  Future<void> signOut() async {
    if (_cognitoUser != null) {
      await _cognitoUser!.signOut();
    }
    _cognitoUser = null;
    _session = null;
    _authStateController.add(null);
  }
}
