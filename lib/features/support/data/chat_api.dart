import 'package:dio/dio.dart';

class ChatApi {
  static const String _server = 'https://chat.ancestro.ai';
  static const String _agentId = 'default';

  final Dio _dio;
  String? _sessionId;

  ChatApi() : _dio = Dio(BaseOptions(
    baseUrl: _server,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
  ));

  Future<String> sendMessage({
    required String message,
    required List<Map<String, String>> conversationHistory,
    String? userName,
    String? userEmail,
  }) async {
    final response = await _dio.post(
      '/api/widget/chat/$_agentId',
      data: {
        'message': message,
        'conversationHistory': conversationHistory,
        if (_sessionId != null) 'sessionId': _sessionId,
        if (userName != null || userEmail != null)
          'userInfo': <String, dynamic>{
            if (userName != null) 'name': userName,
            if (userEmail != null) 'email': userEmail,
          },
      },
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
