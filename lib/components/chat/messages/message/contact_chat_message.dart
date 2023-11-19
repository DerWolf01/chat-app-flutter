import 'package:flutter/material.dart';
import 'package:chat_app_dart/utils/decorations.dart';

class ContactChatMessage extends StatelessWidget {
  const ContactChatMessage({super.key});
  final Radius radius = const Radius.circular(9);
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
          child: const Text("hallo"))
    ]);
  }
}
