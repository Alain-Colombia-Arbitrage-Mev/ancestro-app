import 'package:dio/dio.dart';

class ChatConfig {
  final String botName;
  final String introMessage;
  final String primaryColor;

  const ChatConfig({
    required this.botName,
    required this.introMessage,
    required this.primaryColor,
  });

  factory ChatConfig.fromJson(Map<String, dynamic> json) {
    final widgetConfig = json['widgetConfig'] as Map<String, dynamic>? ?? {};
    return ChatConfig(
      botName: (json['botName'] as String?) ?? 'Ancestro Support',
      introMessage: (json['introMessage'] as String?) ?? 'Hi! How can I help you today?',
      primaryColor: (widgetConfig['primaryColor'] as String?) ?? '#2d92dc',
    );
  }

  static const fallback = ChatConfig(
    botName: 'Ancestro Support',
    introMessage: 'Hi! How can I help you today?',
    primaryColor: '#2d92dc',
  );
}

class ChatApi {
  static const String _server = 'https://chat.ancestro.ai';
  static const String _agentId = 'default';

  final Dio _dio;
  String? _sessionId;
  ChatConfig? _config;

  ChatApi()
      : _dio = Dio(BaseOptions(
          baseUrl: _server,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
        ));

  /// Fetch bot config (name, intro message, colors)
  Future<ChatConfig> getConfig() async {
    if (_config != null) return _config!;
    try {
      final response = await _dio.get('/api/widget/config/$_agentId');
      _config = ChatConfig.fromJson(response.data as Map<String, dynamic>);
      return _config!;
    } catch (_) {
      return ChatConfig.fallback;
    }
  }

  /// Send a message and get bot response
  Future<String> sendMessage({
    required String message,
    required List<Map<String, String>> conversationHistory,
    String? userName,
    String? userEmail,
    String? userPhone,
  }) async {
    final body = <String, dynamic>{
      'message': message,
      'conversationHistory': conversationHistory,
      'sessionId': _sessionId,
    };

    if (userName != null || userEmail != null || userPhone != null) {
      body['userInfo'] = <String, dynamic>{
        if (userName != null) 'name': userName,
        if (userEmail != null) 'email': userEmail,
        if (userPhone != null) 'phone': userPhone,
      };
    }

    final response = await _dio.post(
      '/api/widget/chat/$_agentId',
      data: body,
    );

    final data = response.data as Map<String, dynamic>;
    if (data['sessionId'] != null) {
      _sessionId = data['sessionId'] as String;
    }
    return (data['response'] as String?) ?? 'No response';
  }

  void resetSession() {
    _sessionId = null;
  }
}
