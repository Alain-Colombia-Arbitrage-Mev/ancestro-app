import 'package:freezed_annotation/freezed_annotation.dart';

part 'solar_proposal.freezed.dart';
part 'solar_proposal.g.dart';

@freezed
class SolarProposal with _$SolarProposal {
  const factory SolarProposal({
    required double systemSizeKw,
    required int numberOfPanels,
    required double estimatedAnnualProductionKwh,
    required double monthlySavings,
    required double totalCost,
    required double monthlyPayment,
    required int coverageYears,
    String? propertyImageUrl,
  }) = _SolarProposal;

  factory SolarProposal.fromJson(Map<String, dynamic> json) =>
      _$SolarProposalFromJson(json);
}
