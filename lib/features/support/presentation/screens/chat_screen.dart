import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_input.dart';
import '../../data/chat_api.dart';
import '../../domain/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatApi = ChatApi();

  // Contact form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Chat controllers
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  final List<ChatMessage> _messages = [];
  bool _isSending = false;
  bool _isLoadingConfig = true;
  String _botName = 'Solari';

  // User info
  String? _userName;
  String? _userEmail;
  String? _userPhone;
  bool _showContactForm = true;

  @override
  void initState() {
    super.initState();
    _loadSavedContact();
  }

  Future<void> _loadSavedContact() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('chat_user_name');
    final email = prefs.getString('chat_user_email');
    final phone = prefs.getString('chat_user_phone');

    if (name != null && email != null && phone != null) {
      _userName = name;
      _userEmail = email;
      _userPhone = phone;
      _showContactForm = false;
      _loadConfig();
    } else {
      setState(() => _isLoadingConfig = false);
    }
  }

  Future<void> _saveContactAndStart() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('chat_user_name', name);
    await prefs.setString('chat_user_email', email);
    await prefs.setString('chat_user_phone', phone);

    _userName = name;
    _userEmail = email;
    _userPhone = phone;

    setState(() => _showContactForm = false);
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    setState(() => _isLoadingConfig = true);
    final config = await _chatApi.getConfig();
    if (mounted) {
      setState(() {
        _botName = config.botName;
        _messages.add(ChatMessage(
          text: config.introMessage,
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isLoadingConfig = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isSending) return;

    _messageController.clear();
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isSending = true;
    });
    _scrollToBottom();

    try {
      final history = _messages.map((m) => m.toHistoryEntry()).toList();
      final response = await _chatApi.sendMessage(
        message: text,
        conversationHistory: history,
        userName: _userName,
        userEmail: _userEmail,
        userPhone: _userPhone,
      );

      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: response,
            isUser: false,
            timestamp: DateTime.now(),
          ));
          _isSending = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: 'Sorry, I couldn\'t connect. Please try again.',
            isUser: false,
            timestamp: DateTime.now(),
          ));
          _isSending = false;
        });
        _scrollToBottom();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF2D92DC),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.support_agent, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _botName,
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Online',
                    style: AppTypography.caption.copyWith(color: AppColors.success),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _showContactForm ? _buildContactForm() : _buildChat(),
    );
  }

  // ── Contact Form ──
  Widget _buildContactForm() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  // Icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: Color(0x1A2D92DC),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chat_bubble_outline, color: Color(0xFF2D92DC), size: 28),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Before we start',
                    textAlign: TextAlign.center,
                    style: AppTypography.heading.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please tell us a bit about yourself so we can assist you better.',
                    textAlign: TextAlign.center,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 28),
                  AncestroInput(
                    label: 'Name',
                    hint: 'Your full name',
                    controller: _nameController,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  AncestroInput(
                    label: 'Email',
                    hint: 'your@email.com',
                    controller: _emailController,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  AncestroInput(
                    label: 'Phone',
                    hint: '+1 (555) 000-0000',
                    controller: _phoneController,
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 28),
                  AncestroButton(
                    label: 'Start Chat',
                    onPressed: _saveContactAndStart,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Chat ──
  Widget _buildChat() {
    return Column(
      children: [
        Expanded(
          child: _isLoadingConfig
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: _messages.length + (_isSending ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isSending) {
                      return _buildTypingIndicator();
                    }
                    return _buildMessageBubble(_messages[index]);
                  },
                ),
        ),
        // Input bar
        Container(
          padding: EdgeInsets.fromLTRB(
            16, 12, 16,
            12 + MediaQuery.of(context).viewPadding.bottom,
          ),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.surfaceVariant, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.inputFill,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.inputStroke, width: 0.5),
                  ),
                  child: TextField(
                    controller: _messageController,
                    focusNode: _focusNode,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: AppTypography.body.copyWith(
                        color: AppColors.placeholderText,
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    maxLines: 4,
                    minLines: 1,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _isSending ? null : _sendMessage,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _isSending
                        ? const Color(0xFF2D92DC).withValues(alpha: 0.5)
                        : const Color(0xFF2D92DC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          color: message.isUser ? const Color(0xFF2D92DC) : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(message.isUser ? 18 : 4),
            bottomRight: Radius.circular(message.isUser ? 4 : 18),
          ),
          border: message.isUser
              ? null
              : Border.all(color: AppColors.surfaceVariant, width: 0.5),
        ),
        child: Text(
          message.text,
          style: AppTypography.body.copyWith(
            color: message.isUser ? Colors.white : AppColors.textPrimary,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
          ),
          border: Border.all(color: AppColors.surfaceVariant, width: 0.5),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TypingDot(delay: 0),
            SizedBox(width: 5),
            _TypingDot(delay: 150),
            SizedBox(width: 5),
            _TypingDot(delay: 300),
          ],
        ),
      ),
    );
  }
}

class _TypingDot extends StatefulWidget {
  final int delay;
  const _TypingDot({required this.delay});

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: AppColors.textTertiary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
