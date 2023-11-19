import 'package:chat_app_dart/components/ripple_button/ripple_button.dart';
import 'package:flutter/material.dart';

class ExpandedRipple extends RippleButton {
  const ExpandedRipple(
      {super.key,
      super.child,
      super.decoration,
      super.focusColor,
      super.onTap,
      super.padding,
      super.splashColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: RippleButton(
          key: key,
          decoration: decoration,
          focusColor: focusColor,
          onTap: onTap,
          padding: padding,
          splashColor: splashColor,
          child: child,
        ));
  }
}
