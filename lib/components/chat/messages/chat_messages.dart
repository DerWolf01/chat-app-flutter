import 'package:chat_app_dart/components/chat/messages/message/contact_chat_message.dart';
import 'package:chat_app_dart/components/chat/messages/message/self_chat_message.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});
  final Radius radius = const Radius.circular(9);

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      ContactChatMessage(),
      SelfChatMessage(),
    ]);
  }
}
