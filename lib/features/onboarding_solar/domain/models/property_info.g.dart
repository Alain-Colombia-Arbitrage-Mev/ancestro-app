// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PropertyInfoImpl _$$PropertyInfoImplFromJson(Map<String, dynamic> json) =>
    _$PropertyInfoImpl(
      propertyType: $enumDecode(_$PropertyTypeEnumMap, json['propertyType']),
      roofSizeSqFt: (json['roofSizeSqFt'] as num).toDouble(),
      monthlyConsumptionKwh: (json['monthlyConsumptionKwh'] as num).toDouble(),
      utilityProvider: json['utilityProvider'] as String?,
    );

Map<String, dynamic> _$$PropertyInfoImplToJson(_$PropertyInfoImpl instance) =>
    <String, dynamic>{
      'propertyType': _$PropertyTypeEnumMap[instance.propertyType]!,
      'roofSizeSqFt': instance.roofSizeSqFt,
      'monthlyConsumptionKwh': instance.monthlyConsumptionKwh,
      'utilityProvider': instance.utilityProvider,
    };

const _$PropertyTypeEnumMap = {
  PropertyType.singleFamily: 'singleFamily',
  PropertyType.multiFamily: 'multiFamily',
  PropertyType.commercial: 'commercial',
  PropertyType.other: 'other',
};
