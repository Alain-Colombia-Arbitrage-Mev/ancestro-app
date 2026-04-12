import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/auth_user.dart';
import '../../../../core/config/env.dart';
import '../../data/mock_partner_repository.dart';
import '../../domain/models/partner_contact.dart';
import '../../domain/models/partner_onboarding_state.dart';
import '../../domain/partner_repository.dart';

class PartnerOnboardingNotifier extends StateNotifier<PartnerOnboardingState> {
  final PartnerRepository _repo;
  PartnerOnboardingNotifier(this._repo) : super(const PartnerOnboardingState());

  void selectPartnerType(PartnerType type) {
    state = state.copyWith(partnerType: type);
  }

  void setContact(PartnerContact contact) {
    state = state.copyWith(contact: contact);
  }

  void setDetails(Map<String, dynamic> details) {
    state = state.copyWith(details: details);
  }

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<void> submit() async {
    if (state.partnerType == null || state.contact == null) return;
    await _repo.submitPartnerApplication(
      userId: '', // Will be replaced with actual user ID when auth is wired
      partnerType: state.partnerType!,
      contact: state.contact!,
      details: state.details,
    );
    state = state.copyWith(completed: true);
  }
}

final partnerRepositoryProvider = Provider<PartnerRepository>((ref) {
  if (Env.useMocks) return MockPartnerRepository();
  return MockPartnerRepository();
});

final partnerOnboardingProvider =
    StateNotifierProvider<PartnerOnboardingNotifier, PartnerOnboardingState>(
        (ref) {
  final repo = ref.watch(partnerRepositoryProvider);
  return PartnerOnboardingNotifier(repo);
});
