// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_onboarding_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolarOnboardingStateImpl _$$SolarOnboardingStateImplFromJson(
  Map<String, dynamic> json,
) => _$SolarOnboardingStateImpl(
  currentStep: (json['currentStep'] as num?)?.toInt() ?? 0,
  systemType:
      $enumDecodeNullable(_$SystemTypeEnumMap, json['systemType']) ??
      SystemType.solar,
  basicInfo: json['basicInfo'] == null
      ? null
      : BasicInfo.fromJson(json['basicInfo'] as Map<String, dynamic>),
  propertyInfo: json['propertyInfo'] == null
      ? null
      : PropertyInfo.fromJson(json['propertyInfo'] as Map<String, dynamic>),
  proposal: json['proposal'] == null
      ? null
      : SolarProposal.fromJson(json['proposal'] as Map<String, dynamic>),
  creditStatus:
      $enumDecodeNullable(_$CreditStatusEnumMap, json['creditStatus']) ??
      CreditStatus.pending,
  documents:
      (json['documents'] as List<dynamic>?)
          ?.map((e) => UploadedDocument.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  agreements:
      (json['agreements'] as List<dynamic>?)
          ?.map((e) => Agreement.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  propertyPhotos:
      (json['propertyPhotos'] as List<dynamic>?)
          ?.map((e) => PropertyPhoto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  inspection: json['inspection'] == null
      ? null
      : InspectionSchedule.fromJson(json['inspection'] as Map<String, dynamic>),
  completed: json['completed'] as bool? ?? false,
);

Map<String, dynamic> _$$SolarOnboardingStateImplToJson(
  _$SolarOnboardingStateImpl instance,
) => <String, dynamic>{
  'currentStep': instance.currentStep,
  'systemType': _$SystemTypeEnumMap[instance.systemType]!,
  'basicInfo': instance.basicInfo,
  'propertyInfo': instance.propertyInfo,
  'proposal': instance.proposal,
  'creditStatus': _$CreditStatusEnumMap[instance.creditStatus]!,
  'documents': instance.documents,
  'agreements': instance.agreements,
  'propertyPhotos': instance.propertyPhotos,
  'inspection': instance.inspection,
  'completed': instance.completed,
};

const _$SystemTypeEnumMap = {
  SystemType.solar: 'solar',
  SystemType.ev: 'ev',
  SystemType.both: 'both',
};

const _$CreditStatusEnumMap = {
  CreditStatus.pending: 'pending',
  CreditStatus.approved: 'approved',
  CreditStatus.denied: 'denied',
};
