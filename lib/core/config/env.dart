class Env {
  Env._();

  static const bool useMocks = true;

  // Cognito config — replace with real values when connecting backend
  static const String cognitoUserPoolId = 'us-east-1_XXXXXXXXX';
  static const String cognitoClientId = 'xxxxxxxxxxxxxxxxxxxxxxxxxx';
  static const String cognitoRegion = 'us-east-1';

  // API
  static const String apiBaseUrl = 'https://api.ancestro.ai/v1';
}
