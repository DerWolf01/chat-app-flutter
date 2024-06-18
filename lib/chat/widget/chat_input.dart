import 'dart:async';

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
      SendButtonWidget(
        onTap: () async {
          textEditingController.clear();
          if (value.isEmpty) {
            return;
          }
          await chatService.sendMessage(value);

          value = "";
        },
      )
    ]);
  }
}

class SendButtonWidget extends StatefulWidget {
  const SendButtonWidget({required this.onTap, super.key});
  final FutureOr<void> Function() onTap;
  @override
  State<StatefulWidget> createState() => SendButtonWidgetState();
}

class SendButtonWidgetState extends State<SendButtonWidget> {
  int animation = 0;
  Duration firstButtonDuration = const Duration(milliseconds: 355);
  Duration secondButtonDuration = const Duration(milliseconds: 355);

  double firstButtonScale = 1.0;
  double secondButtonScale = 0.0;

  double firstButtonX = 0.0;
  double secondButtonX = -159;

  Curve firstButtonCurve = Curves.easeInOutSine;
  Curve secondButtonCurve = Curves.easeInOutSine;

  animate1() {
    setState(() {
      secondButtonDuration = const Duration(milliseconds: 355);
      firstButtonDuration = const Duration(milliseconds: 555);

      firstButtonX = 159;
      firstButtonScale = 0.1;
    });

    Future.delayed(
      Duration(milliseconds: 755),
      () {
        setState(() {
          firstButtonDuration = const Duration(milliseconds: 0);
          firstButtonX = -159;
          secondButtonX = 0;
          secondButtonScale = 1.0;
          animation = 1;
        });
      },
    );
  }

  animate2() {
    setState(() {
      firstButtonDuration = const Duration(milliseconds: 355);
      secondButtonDuration = const Duration(milliseconds: 555);

      secondButtonX = 159;
      secondButtonScale = 0.1;
    });
    Future.delayed(
      Duration(milliseconds: 755),
      () {
        setState(() {
          secondButtonDuration = const Duration(milliseconds: 0);
          secondButtonX = -159;

          firstButtonX = 0;
          firstButtonScale = 1.0;
          animation = 0;
        });
      },
    );
  }

  animate() {
    if (animation == 0) {
      animate1();
      return;
    }
    animate2();
  }

  Icon get icon => const Icon(
        Icons.send_rounded,
        color: Colors.white,
      );
  @override
  Widget build(BuildContext context) {
    return FancyRippleButton(
      onTap: () async {
        animate();
        await widget.onTap();
      },
      child: Stack(clipBehavior: Clip.antiAlias, children: [
        AnimatedScale(
            curve: firstButtonCurve,
            duration: firstButtonDuration,
            scale: firstButtonScale,
            child: AnimatedContainer(
                curve: firstButtonCurve,
                transform: Matrix4.translationValues(firstButtonX, 0, 0),
                duration: firstButtonDuration,
                child: icon)),
        AnimatedScale(
            curve: secondButtonCurve,
            duration: secondButtonDuration,
            scale: secondButtonScale,
            child: AnimatedContainer(
                curve: secondButtonCurve,
                transform: Matrix4.translationValues(secondButtonX, 0, 0),
                duration: secondButtonDuration,
                child: icon)),
      ]),
    );
  }
}
