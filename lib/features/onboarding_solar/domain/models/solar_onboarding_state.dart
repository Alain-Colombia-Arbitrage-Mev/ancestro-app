import 'package:freezed_annotation/freezed_annotation.dart';

import 'basic_info.dart';
import 'property_info.dart';
import 'solar_proposal.dart';
import 'uploaded_document.dart';
import 'agreement.dart';
import 'property_photo.dart';
import 'inspection_schedule.dart';

part 'solar_onboarding_state.freezed.dart';
part 'solar_onboarding_state.g.dart';

enum SystemType {
  solar,
  ev,
  both,
}

enum CreditStatus {
  pending,
  approved,
  denied,
}

@freezed
class SolarOnboardingState with _$SolarOnboardingState {
  const factory SolarOnboardingState({
    @Default(0) int currentStep,
    @Default(SystemType.solar) SystemType systemType,
    BasicInfo? basicInfo,
    PropertyInfo? propertyInfo,
    SolarProposal? proposal,
    @Default(CreditStatus.pending) CreditStatus creditStatus,
    @Default([]) List<UploadedDocument> documents,
    @Default([]) List<Agreement> agreements,
    @Default([]) List<PropertyPhoto> propertyPhotos,
    InspectionSchedule? inspection,
    @Default(false) bool completed,
  }) = _SolarOnboardingState;

  factory SolarOnboardingState.fromJson(Map<String, dynamic> json) =>
      _$SolarOnboardingStateFromJson(json);
}
