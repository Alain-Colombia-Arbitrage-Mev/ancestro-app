import '../../../core/config/constants.dart';
import '../domain/models/referral.dart';
import '../domain/referral_repository.dart';

class MockReferralRepository implements ReferralRepository {
  @override
  Future<String> getReferralCode({required String userId}) async {
    await Future.delayed(AppConstants.mockDelay);
    return AppConstants.mockReferralCode;
  }

  @override
  Future<List<Referral>> getReferrals({required String userId}) async {
    await Future.delayed(AppConstants.mockDelay);
    return const [
      Referral(
        code: 'MOCK123',
        referrerId: 'user-1',
        referredEmail: 'friend1@example.com',
        status: ReferralStatus.completed,
        reward: 100.0,
      ),
      Referral(
        code: 'MOCK123',
        referrerId: 'user-1',
        referredEmail: 'friend2@example.com',
        status: ReferralStatus.registered,
      ),
      Referral(
        code: 'MOCK123',
        referrerId: 'user-1',
        referredEmail: 'friend3@example.com',
        status: ReferralStatus.pending,
      ),
    ];
  }
}
