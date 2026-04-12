// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_onboarding_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnerOnboardingStateImpl _$$PartnerOnboardingStateImplFromJson(
  Map<String, dynamic> json,
) => _$PartnerOnboardingStateImpl(
  currentStep: (json['currentStep'] as num?)?.toInt() ?? 0,
  partnerType: $enumDecodeNullable(_$PartnerTypeEnumMap, json['partnerType']),
  contact: json['contact'] == null
      ? null
      : PartnerContact.fromJson(json['contact'] as Map<String, dynamic>),
  details: json['details'] as Map<String, dynamic>? ?? const {},
  completed: json['completed'] as bool? ?? false,
);

Map<String, dynamic> _$$PartnerOnboardingStateImplToJson(
  _$PartnerOnboardingStateImpl instance,
) => <String, dynamic>{
  'currentStep': instance.currentStep,
  'partnerType': _$PartnerTypeEnumMap[instance.partnerType],
  'contact': instance.contact,
  'details': instance.details,
  'completed': instance.completed,
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
