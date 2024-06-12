import 'package:flutter/material.dart';
import 'package:chat_app_dart/utils/colors.dart';

class LableSettings {
  double focusedY(BuildContext context) => -35;
  double bluredY(BuildContext context) => 0.0;

  double getY(BuildContext context, bool focused, bool hasValue) {
    if (focused || hasValue) {
      return focusedY(context);
    }
    return bluredY(context);
  }

  double focusedX(BuildContext context) => 225.0;
  double bluredX(BuildContext context) => 0.0;
  double bluredButHasValueX(BuildContext context) => 225.0;
  double getX(BuildContext context, bool focused, bool hasValue) {
    if (focused || hasValue) {
      return focusedX(context);
    }
    // else if (hasValue) {
    //   return bluredButHasValueX(context);
    // }
    return bluredX(context);
  }

  Matrix4 getTranslationValues(
          BuildContext context, bool focused, bool hasValue) =>
      Matrix4.translationValues(getX(context, focused, hasValue),
          getY(context, focused, hasValue), 0.0);

  TextStyle getStyle(bool focused) {
    if (focused) {
      return TextStyle(color: PRIMARY, shadows: [
        Shadow(blurRadius: 25, offset: Offset(0, 3), color: SECONDARY)
      ]);
    }

    return const TextStyle(
      color: Color.fromARGB(129, 0, 0, 0),
    );
  }
}

class InputLable extends StatelessWidget {
  InputLable(this.lable, this.focused, this.hasValue, {super.key});

  final bool focused;
  final bool hasValue;
  late final String lable;
  final LableSettings lableSettings = LableSettings();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        curve: Curves.elasticOut,
        alignment: Alignment.centerLeft,
        transform:
            lableSettings.getTranslationValues(context, focused, hasValue),
        duration: const Duration(milliseconds: 1333),
        child: Text(lable, style: lableSettings.getStyle(focused)));
  }
}
