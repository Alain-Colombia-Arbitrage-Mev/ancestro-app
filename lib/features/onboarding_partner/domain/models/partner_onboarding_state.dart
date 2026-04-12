import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/auth/auth_user.dart';
import 'partner_contact.dart';

part 'partner_onboarding_state.freezed.dart';
part 'partner_onboarding_state.g.dart';

@freezed
class PartnerOnboardingState with _$PartnerOnboardingState {
  const factory PartnerOnboardingState({
    @Default(0) int currentStep,
    PartnerType? partnerType,
    PartnerContact? contact,
    @Default({}) Map<String, dynamic> details,
    @Default(false) bool completed,
  }) = _PartnerOnboardingState;

  factory PartnerOnboardingState.fromJson(Map<String, dynamic> json) =>
      _$PartnerOnboardingStateFromJson(json);
}
