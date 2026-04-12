// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserImpl _$$AuthUserImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      partnerType: $enumDecodeNullable(
        _$PartnerTypeEnumMap,
        json['partnerType'],
      ),
      referredBy: json['referredBy'] as String?,
      onboardingComplete: json['onboardingComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$$AuthUserImplToJson(_$AuthUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'role': _$UserRoleEnumMap[instance.role]!,
      'partnerType': _$PartnerTypeEnumMap[instance.partnerType],
      'referredBy': instance.referredBy,
      'onboardingComplete': instance.onboardingComplete,
    };

const _$UserRoleEnumMap = {
  UserRole.customer: 'customer',
  UserRole.partner: 'partner',
};

const _$PartnerTypeEnumMap = {
  PartnerType.socioInversionista: 'socioInversionista',
  PartnerType.socioEstrategico: 'socioEstrategico',
  PartnerType.instaladorCertificado: 'instaladorCertificado',
  PartnerType.empresaEnergia: 'empresaEnergia',
  PartnerType.socioLogistica: 'socioLogistica',
  PartnerType.asesorConsultor: 'asesorConsultor',
  PartnerType.gobiernoMunicipio: 'gobiernoMunicipio',
};
