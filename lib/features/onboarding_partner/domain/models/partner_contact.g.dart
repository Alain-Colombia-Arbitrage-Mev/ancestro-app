// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnerContactImpl _$$PartnerContactImplFromJson(Map<String, dynamic> json) =>
    _$PartnerContactImpl(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      company: json['company'] as String?,
    );

Map<String, dynamic> _$$PartnerContactImplToJson(
  _$PartnerContactImpl instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'country': instance.country,
  'city': instance.city,
  'company': instance.company,
};
