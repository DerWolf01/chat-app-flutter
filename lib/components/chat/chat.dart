import 'package:chat_app_dart/controller/side_menu_controller.dart';
import 'package:chat_app_dart/utils/decorations.dart';
import 'package:chat_app_dart/components/chat/chat_input.dart';
import 'package:chat_app_dart/components/chat/messages/chat_messages.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  final Radius radius = const Radius.circular(9);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  transform: Matrix4.translationValues(0, 5, 0),
                  child: FancySideMenuTrigger(
                    child: const Icon(Icons.menu_rounded),
                  )),
              const VerticalDivider(
                width: 25,
                color: Colors.transparent,
              ),
              Expanded(
                  child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.07,
                      decoration: BoxDecoration(
                          boxShadow: ShadowDecoration().boxShadow,
                          color: ShadowDecoration().color,
                          borderRadius: BorderRadius.only(
                              bottomLeft: radius, bottomRight: radius)),
                      padding: const EdgeInsets.only(left: 15),
                      child: const Row(
                        children: [Icon(Icons.person_2_sharp), Text("contact")],
                      )))
            ]),
            const Column(children: [
              ChatMessages(),
              Divider(
                height: 25.0,
                color: Colors.transparent,
              ),
              ChatInput()
            ]),
          ],
        ));
  }
}
