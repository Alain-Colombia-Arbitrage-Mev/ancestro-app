import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/env.dart';
import 'auth_repository.dart';
import 'auth_user.dart';
import 'mock_auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (Env.useMocks) return MockAuthRepository();
  return MockAuthRepository();
});

final authStateProvider = StreamProvider<AuthUser?>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges;
});
