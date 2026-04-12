class Env {
  Env._();

  /// Toggle mocks: pass --dart-define=USE_MOCKS=false to disable
  static const bool useMocks =
      bool.fromEnvironment('USE_MOCKS', defaultValue: true);

  // Cognito — injected at build time via --dart-define
  static const String cognitoUserPoolId =
      String.fromEnvironment('COGNITO_USER_POOL_ID');
  static const String cognitoClientId =
      String.fromEnvironment('COGNITO_CLIENT_ID');
  static const String cognitoRegion =
      String.fromEnvironment('COGNITO_REGION', defaultValue: 'us-east-1');

  // API
  static const String apiBaseUrl =
      String.fromEnvironment('API_BASE_URL', defaultValue: 'https://api.ancestro.ai/v1');
}
