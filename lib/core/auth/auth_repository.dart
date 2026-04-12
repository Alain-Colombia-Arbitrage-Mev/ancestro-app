import 'auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<AuthUser> signInWithGoogle();

  Future<AuthUser> signInWithApple();

  Future<void> signInWithPhone({required String phoneNumber});

  Future<AuthUser> confirmPhoneSignIn({required String code});

  Future<AuthUser> signUp({
    required String email,
    required String password,
    required UserRole role,
    String? referralCode,
  });

  Future<void> confirmSignUp({
    required String email,
    required String code,
  });

  Future<void> forgotPassword({required String email});

  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  });

  Future<void> signOut();
}
