import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';

class ChatFab extends StatelessWidget {
  const ChatFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'chat_fab',
      onPressed: () => context.push(RouteNames.chat),
      backgroundColor: const Color(0xFF2D92DC),
      elevation: 6,
      child: const Icon(
        Icons.chat_bubble_rounded,
        color: Colors.white,
        size: 22,
      ),
    );
  }
}
