import 'package:chat_app_dart/components/chat/messages/message/contact_chat_message.dart';
import 'package:chat_app_dart/components/chat/messages/message/self_chat_message.dart';
import 'package:chat_app_dart/components/chat/service/chat_service.dart';
import 'package:chat_app_dart/firestore/model/user.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages(this.chosenContact, {super.key});
  final Radius radius = const Radius.circular(9);
  final User? chosenContact;

  final ChatService chatService = getIt<ChatService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) => snapshot.data != null
          ? Column(
              children:
                  snapshot.data!.map((m) => ContactChatMessage(m)).toList(),
              // SelfChatMessage(),
            )
          : Center(child: Text("Make the first step ")),
      future: chatService.getMessages(),
    );
  }
}
