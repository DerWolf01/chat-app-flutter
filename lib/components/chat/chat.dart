import 'package:chat_app_dart/utils/decorations.dart';
import 'package:chat_app_dart/components/chat/chat_input.dart';
import 'package:chat_app_dart/components/chat/messages/chat_messages.dart';
import 'package:flutter/material.dart';
class Chat extends StatelessWidget {
  const Chat({super.key});

  final Radius radius = const Radius.circular(9);
  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: const BoxDecoration(color: Colors.amber),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
            decoration: BoxDecoration(
                boxShadow: ShadowDecoration().boxShadow,
                color: ShadowDecoration().color,
                borderRadius:
                    BorderRadius.only(bottomLeft: radius, bottomRight: radius)),
            child: const Row(
              children: [Icon(Icons.person_2_sharp), Text("contact")],
            )),
        const Padding(
          padding: EdgeInsets.only(bottom: 25, left: 25, right: 25),
          child: Column(children: [
            ChatMessages(),
            Divider(
              height: 25.0,
              color: Colors.transparent,
            ),
            ChatInput()
          ]),
        )
      ],
    ));
  }
}
