import 'dart:async';
import 'dart:math';
import '../config/constants.dart';
import 'auth_repository.dart';
import 'auth_user.dart';

class MockAuthRepository implements AuthRepository {
  final _authStateController = StreamController<AuthUser?>.broadcast();
  AuthUser? _currentUser;
  String? _pendingPhoneNumber;

  @override
  Stream<AuthUser?> get authStateChanges => _authStateController.stream;

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
    final user = AuthUser(
      id: _generateId(),
      email: email,
      role: UserRole.customer,
      onboardingComplete: false,
    );
    _currentUser = user;
    _authStateController.add(user);
    return user;
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    await Future.delayed(AppConstants.mockDelay);
    final user = AuthUser(
      id: _generateId(),
      email: 'google.user@gmail.com',
      role: UserRole.customer,
      onboardingComplete: false,
    );
    _currentUser = user;
    _authStateController.add(user);
    return user;
  }

  @override
  Future<AuthUser> signInWithApple() async {
    await Future.delayed(AppConstants.mockDelay);
    final user = AuthUser(
      id: _generateId(),
      email: 'apple.user@icloud.com',
      role: UserRole.customer,
      onboardingComplete: false,
    );
    _currentUser = user;
    _authStateController.add(user);
    return user;
  }

  @override
  Future<void> signInWithPhone({required String phoneNumber}) async {
    await Future.delayed(AppConstants.mockDelay);
    _pendingPhoneNumber = phoneNumber;
  }

  @override
  Future<AuthUser> confirmPhoneSignIn({required String code}) async {
    await Future.delayed(AppConstants.mockDelay);
    final user = AuthUser(
      id: _generateId(),
      email: '',
      phone: _pendingPhoneNumber,
      role: UserRole.customer,
      onboardingComplete: false,
    );
    _currentUser = user;
    _authStateController.add(user);
    _pendingPhoneNumber = null;
    return user;
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
    required UserRole role,
    String? referralCode,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
    final user = AuthUser(
      id: _generateId(),
      email: email,
      role: role,
      referredBy: referralCode,
      onboardingComplete: false,
    );
    _currentUser = user;
    _authStateController.add(user);
    return user;
  }

  @override
  Future<void> confirmSignUp({
    required String email,
    required String code,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await Future.delayed(AppConstants.mockDelay);
  }

  @override
  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(AppConstants.mockDelay);
    _currentUser = null;
    _authStateController.add(null);
  }

  String _generateId() => Random().nextInt(999999).toString().padLeft(6, '0');
}
