import 'package:chat_app_dart/components/form_components/decorators/data.dart';
import 'package:chat_app_dart/components/form_components/input_field_label.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  InputField(
      {required this.lable, required this.validationRequirements, super.key});

  final List<Data> validationRequirements;
  final String lable;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final Map<String, String> errorMessages = {};

  ValueNotifier<bool> focused = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(() {
      focused.value = !focused.value;
    });

    return AnimatedContainer(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(052, 0, 0, 0),
                blurRadius: 25,
              )
            ]),
        width: 335,
        height: 35,
        padding: const EdgeInsets.only(left: 15, right: 15),
        duration: const Duration(milliseconds: 250),
        child: Stack(children: [
          ValueListenableBuilder(
              valueListenable: focused,
              builder: (context, value, child) {
                return InputLable(
                    lable, value, _textEditingController.value.text.isNotEmpty);
              }),
          AnimatedContainer(
              duration: const Duration(milliseconds: 251),
              transform: Matrix4.translationValues(0, -5, 0),
              child: Center(
                  child: TextField(
                focusNode: _focusNode,
                controller: _textEditingController,
                cursorColor: const Color.fromARGB(255, 234, 59, 237),
                decoration: const InputDecoration(border: InputBorder.none),
              )))
        ]));
  }

  String get value {
    return _textEditingController.text;
  }

  bool check() {
    var ready = true;
    for (var validationRequirement in validationRequirements) {
      ValidationResult validationResult = validationRequirement.validate(value);

      if (!validationResult.valid) {
        ready = false;
        errorMessages[validationRequirement.runtimeType.toString()] =
            validationResult.errorMessage;
        print(validationResult.errorMessage);
      }
    }
    return ready;
  }
}
