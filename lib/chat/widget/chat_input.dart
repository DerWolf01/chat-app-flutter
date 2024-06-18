import 'package:chat_app_dart/chat/service/chat_service.dart';
import 'package:chat_app_dart/form_components/input_field.dart';
import 'package:chat_app_dart/ripple_button/fancy_ripple_button.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  ChatInput({super.key});
  final ChatService chatService = getIt<ChatService>();
  late final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    String value = "";
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          child: InputField(
        getTextEditingControllerOnInit: (controller) {
          textEditingController = controller;
        },
        onChanged: (textValue) {
          value = textValue;
        },
        lable: "message",
      )),
      const VerticalDivider(
        width: 15,
        color: Colors.transparent,
      ),
      FancyRippleButton(
        onTap: () async {
          if (value.isEmpty) {
            return;
          }
          await chatService.sendMessage(value);
          textEditingController.clear();
          value = "";
        },
        child: const Icon(Icons.send_rounded),
      )
    ]);
  }
}
