import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner_contact.freezed.dart';
part 'partner_contact.g.dart';

@freezed
class PartnerContact with _$PartnerContact {
  const factory PartnerContact({
    required String fullName,
    required String email,
    required String phone,
    required String country,
    required String city,
    String? company,
  }) = _PartnerContact;

  factory PartnerContact.fromJson(Map<String, dynamic> json) =>
      _$PartnerContactFromJson(json);
}
