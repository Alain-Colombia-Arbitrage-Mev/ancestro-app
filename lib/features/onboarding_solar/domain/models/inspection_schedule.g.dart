// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InspectionScheduleImpl _$$InspectionScheduleImplFromJson(
  Map<String, dynamic> json,
) => _$InspectionScheduleImpl(
  date: DateTime.parse(json['date'] as String),
  timeSlot: json['timeSlot'] as String,
  inspectorName: json['inspectorName'] as String?,
  inspectorPhoto: json['inspectorPhoto'] as String?,
  inspectorPhone: json['inspectorPhone'] as String?,
);

Map<String, dynamic> _$$InspectionScheduleImplToJson(
  _$InspectionScheduleImpl instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'timeSlot': instance.timeSlot,
  'inspectorName': instance.inspectorName,
  'inspectorPhoto': instance.inspectorPhoto,
  'inspectorPhone': instance.inspectorPhone,
};
