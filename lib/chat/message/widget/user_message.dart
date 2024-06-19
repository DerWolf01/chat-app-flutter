import 'package:chat_app_dart/chat/message/message_model.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/utils/colors.dart';
import 'package:chat_app_dart/utils/decorations.dart';

class ContactMessage extends StatelessWidget {
  const ContactMessage(this.message, {super.key});
  final Radius radius = const Radius.circular(9);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
              boxShadow: ShadowDecoration().boxShadow,
              borderRadius: BorderRadius.only(
                  topRight: radius, bottomRight: radius, topLeft: radius),
              color: secondary),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(message.content),
                Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      DateTime.fromMillisecondsSinceEpoch(message.id)
                          .toIso8601String()
                          .substring(11, 16),
                      style: TextStyle(color: Colors.white),
                    ))
              ]))
    ]);
  }
}
