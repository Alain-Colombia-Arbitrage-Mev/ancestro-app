import 'package:freezed_annotation/freezed_annotation.dart';

part 'inspection_schedule.freezed.dart';
part 'inspection_schedule.g.dart';

@freezed
class InspectionSchedule with _$InspectionSchedule {
  const factory InspectionSchedule({
    required DateTime date,
    required String timeSlot,
    String? inspectorName,
    String? inspectorPhoto,
    String? inspectorPhone,
  }) = _InspectionSchedule;

  factory InspectionSchedule.fromJson(Map<String, dynamic> json) =>
      _$InspectionScheduleFromJson(json);
}
