import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

enum UserRole { customer, partner }

enum PartnerType {
  socioInversionista,
  socioEstrategico,
  instaladorCertificado,
  empresaEnergia,
  socioLogistica,
  asesorConsultor,
  gobiernoMunicipio,
}

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String email,
    String? phone,
    required UserRole role,
    PartnerType? partnerType,
    String? referredBy,
    @Default(false) bool onboardingComplete,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}
