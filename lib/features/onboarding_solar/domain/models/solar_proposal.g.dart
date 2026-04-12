// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_proposal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolarProposalImpl _$$SolarProposalImplFromJson(Map<String, dynamic> json) =>
    _$SolarProposalImpl(
      systemSizeKw: (json['systemSizeKw'] as num).toDouble(),
      numberOfPanels: (json['numberOfPanels'] as num).toInt(),
      estimatedAnnualProductionKwh:
          (json['estimatedAnnualProductionKwh'] as num).toDouble(),
      monthlySavings: (json['monthlySavings'] as num).toDouble(),
      totalCost: (json['totalCost'] as num).toDouble(),
      monthlyPayment: (json['monthlyPayment'] as num).toDouble(),
      coverageYears: (json['coverageYears'] as num).toInt(),
      propertyImageUrl: json['propertyImageUrl'] as String?,
    );

Map<String, dynamic> _$$SolarProposalImplToJson(_$SolarProposalImpl instance) =>
    <String, dynamic>{
      'systemSizeKw': instance.systemSizeKw,
      'numberOfPanels': instance.numberOfPanels,
      'estimatedAnnualProductionKwh': instance.estimatedAnnualProductionKwh,
      'monthlySavings': instance.monthlySavings,
      'totalCost': instance.totalCost,
      'monthlyPayment': instance.monthlyPayment,
      'coverageYears': instance.coverageYears,
      'propertyImageUrl': instance.propertyImageUrl,
    };
