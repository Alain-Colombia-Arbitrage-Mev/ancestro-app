import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/auth_repository.dart';
import '../../../core/auth/auth_user.dart';

enum AuthStatus { idle, loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? error;
  final bool codeSent;

  const AuthState({
    this.status = AuthStatus.idle,
    this.error,
    this.codeSent = false,
  });

  AuthState copyWith({AuthStatus? status, String? error, bool? codeSent}) {
    return AuthState(
      status: status ?? this.status,
      error: error,
      codeSent: codeSent ?? this.codeSent,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;

  AuthNotifier(this._repo) : super(const AuthState());

  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.signIn(email: email, password: password);
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.signInWithGoogle();
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signInWithApple() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.signInWithApple();
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signInWithPhone({required String phoneNumber}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.signInWithPhone(phoneNumber: phoneNumber);
      state = state.copyWith(status: AuthStatus.success, codeSent: true);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required UserRole role,
    String? referralCode,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.signUp(
        email: email,
        password: password,
        role: role,
        referralCode: referralCode,
      );
      state = state.copyWith(status: AuthStatus.success, codeSent: true);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> confirmSignUp({
    required String email,
    required String code,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.confirmSignUp(email: email, code: code);
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> forgotPassword({required String email}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.forgotPassword(email: email);
      state = state.copyWith(status: AuthStatus.success, codeSent: true);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.confirmForgotPassword(
        email: email,
        code: code,
        newPassword: newPassword,
      );
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(status: AuthStatus.idle, error: null);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthNotifier(repo);
});
