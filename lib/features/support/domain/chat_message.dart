class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  Map<String, String> toHistoryEntry() => {
        'role': isUser ? 'user' : 'assistant',
        'content': text,
      };
}
