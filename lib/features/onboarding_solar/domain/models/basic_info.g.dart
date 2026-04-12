// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BasicInfoImpl _$$BasicInfoImplFromJson(Map<String, dynamic> json) =>
    _$BasicInfoImpl(
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
    );

Map<String, dynamic> _$$BasicInfoImplToJson(_$BasicInfoImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
    };
