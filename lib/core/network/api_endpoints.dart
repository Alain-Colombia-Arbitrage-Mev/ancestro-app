import '../config/env.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static String get baseUrl => Env.apiBaseUrl;

  // Auth
  static String get signIn => '$baseUrl/auth/signin';
  static String get signUp => '$baseUrl/auth/signup';

  // Solar
  static String get solarProposal => '$baseUrl/solar/proposal';
  static String get creditCheck => '$baseUrl/solar/credit';
  static String get agreements => '$baseUrl/solar/agreements';
  static String get inspection => '$baseUrl/solar/inspection';

  // Partner
  static String get partnerApplication => '$baseUrl/partner/apply';

  // Referral
  static String get referralCode => '$baseUrl/referral/code';
  static String get referrals => '$baseUrl/referral/list';
}
