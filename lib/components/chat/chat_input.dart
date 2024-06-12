import 'package:chat_app_dart/components/form_components/input_field.dart';
import 'package:chat_app_dart/components/ripple_button/fancy_ripple_button.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          child: InputField(
        lable: "message",
      )),
      const VerticalDivider(
        width: 15,
        color: Colors.transparent,
      ),
      const FancyRippleButton(
        child: Icon(Icons.send_rounded),
      )
    ]);
  }
}
