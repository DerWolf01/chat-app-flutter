import 'dart:async';

import 'package:chat_app_dart/components/ripple_button/ripple_button.dart';
import 'package:chat_app_dart/utils/colors.dart';
import 'package:flutter/material.dart';

class FancyRippleButton extends StatelessWidget {
  const FancyRippleButton({this.child, this.onTap, super.key});

  final FutureOr<void> Function()? onTap;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(23)),
          color: primary,
          boxShadow: [
            BoxShadow(
                blurRadius: 19,
                spreadRadius: 7,
                offset: const Offset(0, 7),
                color: secondary)
          ]),
      child: child,
    );
  }
}
