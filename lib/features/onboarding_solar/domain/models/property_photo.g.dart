// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PropertyPhotoImpl _$$PropertyPhotoImplFromJson(Map<String, dynamic> json) =>
    _$PropertyPhotoImpl(
      id: json['id'] as String,
      category: $enumDecode(_$PhotoCategoryEnumMap, json['category']),
      filePath: json['filePath'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
    );

Map<String, dynamic> _$$PropertyPhotoImplToJson(_$PropertyPhotoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': _$PhotoCategoryEnumMap[instance.category]!,
      'filePath': instance.filePath,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
    };

const _$PhotoCategoryEnumMap = {
  PhotoCategory.roofFront: 'roofFront',
  PhotoCategory.roofBack: 'roofBack',
  PhotoCategory.electricalPanel: 'electricalPanel',
  PhotoCategory.meter: 'meter',
};
