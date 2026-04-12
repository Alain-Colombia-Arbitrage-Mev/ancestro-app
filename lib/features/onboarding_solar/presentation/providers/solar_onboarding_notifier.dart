import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/mock_solar_repository.dart';
import '../../domain/solar_repository.dart';
import '../../domain/models/basic_info.dart';
import '../../domain/models/property_info.dart';
import '../../domain/models/solar_onboarding_state.dart';

final solarRepositoryProvider = Provider<SolarRepository>((ref) {
  return MockSolarRepository();
});

final solarOnboardingProvider =
    StateNotifierProvider<SolarOnboardingNotifier, SolarOnboardingState>((ref) {
  final repo = ref.watch(solarRepositoryProvider);
  return SolarOnboardingNotifier(repo);
});

class SolarOnboardingNotifier extends StateNotifier<SolarOnboardingState> {
  final SolarRepository _repo;

  SolarOnboardingNotifier(this._repo) : super(const SolarOnboardingState());

  void selectSystemType(SystemType type) {
    state = state.copyWith(systemType: type);
    _persistState();
  }

  void setBasicInfo(BasicInfo info) {
    state = state.copyWith(basicInfo: info);
    _persistState();
  }

  void setPropertyInfo(PropertyInfo info) {
    state = state.copyWith(propertyInfo: info);
    _persistState();
  }

  Future<void> generateProposal() async {
    if (state.basicInfo == null || state.propertyInfo == null) return;
    final proposal = await _repo.generateProposal(
      basicInfo: state.basicInfo!,
      propertyInfo: state.propertyInfo!,
      systemType: state.systemType,
    );
    state = state.copyWith(proposal: proposal);
    _persistState();
  }

  Future<void> checkCredit() async {
    final status = await _repo.checkCredit(userId: 'mock-user');
    state = state.copyWith(creditStatus: status);
    _persistState();
  }

  Future<void> loadAgreements() async {
    final agreements = await _repo.getAgreements();
    state = state.copyWith(agreements: agreements);
    _persistState();
  }

  void acceptAgreement(String id) {
    final updated = state.agreements.map((a) {
      if (a.id == id) return a.copyWith(accepted: true);
      return a;
    }).toList();
    state = state.copyWith(agreements: updated);
    _persistState();
  }

  Future<void> scheduleInspection(DateTime date, String timeSlot) async {
    final inspection = await _repo.scheduleInspection(
      userId: 'mock-user',
      date: date,
      timeSlot: timeSlot,
    );
    state = state.copyWith(inspection: inspection);
    _persistState();
  }

  void goToStep(int step) {
    state = state.copyWith(currentStep: step);
    _persistState();
  }

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
    _persistState();
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
      _persistState();
    }
  }

  Future<void> complete() async {
    await _repo.completeOnboarding(userId: 'mock-user');
    state = state.copyWith(completed: true);
    _persistState();
  }

  Future<void> _persistState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'solar_onboarding_state',
      jsonEncode(state.toJson()),
    );
  }

  Future<void> restoreState() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('solar_onboarding_state');
    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      state = SolarOnboardingState.fromJson(json);
    }
  }
}
