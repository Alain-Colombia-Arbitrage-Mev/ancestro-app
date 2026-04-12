import 'package:freezed_annotation/freezed_annotation.dart';

part 'referral.freezed.dart';
part 'referral.g.dart';

enum ReferralStatus {
  pending,
  registered,
  completed,
}

@freezed
class Referral with _$Referral {
  const factory Referral({
    required String code,
    required String referrerId,
    String? referredEmail,
    required ReferralStatus status,
    double? reward,
  }) = _Referral;

  factory Referral.fromJson(Map<String, dynamic> json) =>
      _$ReferralFromJson(json);
}

class ReferralState {
  final String code;
  final List<Referral> referrals;
  final bool isLoading;

  const ReferralState({
    required this.code,
    this.referrals = const [],
    this.isLoading = false,
  });

  ReferralState copyWith({
    String? code,
    List<Referral>? referrals,
    bool? isLoading,
  }) {
    return ReferralState(
      code: code ?? this.code,
      referrals: referrals ?? this.referrals,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
