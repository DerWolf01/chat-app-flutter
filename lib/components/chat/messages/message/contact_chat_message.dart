import 'package:chat_app_dart/components/chat/service/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/utils/decorations.dart';

class ContactChatMessage extends StatelessWidget {
  const ContactChatMessage(this.message, {super.key});
  final Radius radius = const Radius.circular(9);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
              boxShadow: ShadowDecoration().boxShadow,
              borderRadius: BorderRadius.only(
                  topRight: radius, bottomLeft: radius, topLeft: radius),
              color: Colors.white),
          child: Text(message.content))
    ]);
  }
}
