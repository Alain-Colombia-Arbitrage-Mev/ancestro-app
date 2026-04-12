import 'models/referral.dart';

abstract class ReferralRepository {
  Future<String> getReferralCode({required String userId});

  Future<List<Referral>> getReferrals({required String userId});
}
