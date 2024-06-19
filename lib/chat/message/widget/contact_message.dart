import 'package:chat_app_dart/chat/message/message_model.dart';
import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  const UserMessage(this.message, {super.key});
  final Radius radius = const Radius.circular(9);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 29, color: Colors.black.withOpacity(0.11))
              ],
              borderRadius: BorderRadius.only(
                  topRight: radius, bottomLeft: radius, topLeft: radius),
              color: Colors.white),
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
                      style: TextStyle(color: Colors.grey),
                    ))
              ]))
    ]);
  }
}
