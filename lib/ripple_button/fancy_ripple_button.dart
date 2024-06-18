import 'dart:async';

import 'package:chat_app_dart/ripple_button/ripple_button.dart';
import 'package:chat_app_dart/utils/colors.dart';
import 'package:flutter/material.dart';

class FancyRippleButton extends StatelessWidget {
  FancyRippleButton({this.child, this.onTap, super.key});

  final FutureOr<void> Function()? onTap;
  final ValueNotifier<bool> _pressed = ValueNotifier(false);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return
        // ValueListenableBuilder(
        //     valueListenable: _pressed,
        //     builder: (context, pressed, child) => AnimatedScale(
        //         scale: pressed ? 0.85 : 1.0,
        //         duration: Duration(milliseconds: 155),
        //         child:
        RippleButton(
      onTapDown: (d) => _pressed.value = true,
      onTapUp: (d) => _pressed.value = false,
      onTapCancel: () => _pressed.value = false,
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
