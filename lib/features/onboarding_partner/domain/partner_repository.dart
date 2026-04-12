import '../../../core/auth/auth_user.dart';
import 'models/partner_contact.dart';

abstract class PartnerRepository {
  Future<void> submitPartnerApplication({
    required String userId,
    required PartnerType partnerType,
    required PartnerContact contact,
    required Map<String, dynamic> details,
  });
}
