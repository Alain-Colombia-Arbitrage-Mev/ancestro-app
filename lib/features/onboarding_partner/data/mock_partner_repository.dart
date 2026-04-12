import '../../../core/auth/auth_user.dart';
import '../../../core/config/constants.dart';
import '../domain/models/partner_contact.dart';
import '../domain/partner_repository.dart';

class MockPartnerRepository implements PartnerRepository {
  @override
  Future<void> submitPartnerApplication({
    required String userId,
    required PartnerType partnerType,
    required PartnerContact contact,
    required Map<String, dynamic> details,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
  }
}
