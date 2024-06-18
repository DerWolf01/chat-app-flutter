import 'package:chat_app_dart/form_components/input_field_lable.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  InputField(
      {required this.lable,
      this.onChanged,
      this.getTextEditingControllerOnInit,
      super.key});

  final String lable;
  final TextEditingController _textEditingController = TextEditingController();

  final void Function(TextEditingController controller)?
      getTextEditingControllerOnInit;
  final FocusNode _focusNode = FocusNode();
  void Function(String textValue)? onChanged;

  ValueNotifier<bool> focused = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(() {
      focused.value = !focused.value;
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (getTextEditingControllerOnInit != null) {
          getTextEditingControllerOnInit!(_textEditingController);
        }
      },
    );

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
              transform: Matrix4.translationValues(0, -10, 0),
              child: Center(
                  child: TextField(
                focusNode: _focusNode,
                onChanged: onChanged,
                controller: _textEditingController,
                cursorColor: const Color.fromARGB(255, 234, 59, 237),
                decoration: const InputDecoration(border: InputBorder.none),
              )))
        ]));
  }

  String get value {
    return _textEditingController.text;
  }
}
