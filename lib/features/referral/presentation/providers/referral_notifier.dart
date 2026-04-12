import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/env.dart';
import '../../data/mock_referral_repository.dart';
import '../../domain/models/referral.dart';
import '../../domain/referral_repository.dart';

class ReferralNotifier extends StateNotifier<ReferralState> {
  final ReferralRepository _repo;
  ReferralNotifier(this._repo) : super(const ReferralState());

  Future<void> loadReferrals(String userId) async {
    state = state.copyWith(isLoading: true);
    final code = await _repo.getReferralCode(userId: userId);
    final referrals = await _repo.getReferrals(userId: userId);
    state = state.copyWith(code: code, referrals: referrals, isLoading: false);
  }
}

final referralRepositoryProvider = Provider<ReferralRepository>((ref) {
  if (Env.useMocks) return MockReferralRepository();
  return MockReferralRepository();
});

final referralProvider =
    StateNotifierProvider<ReferralNotifier, ReferralState>((ref) {
  final repo = ref.watch(referralRepositoryProvider);
  return ReferralNotifier(repo);
});
