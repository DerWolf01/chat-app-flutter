import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  const RippleButton(
      {super.key,
      this.onTap,
      this.onTapCancel,
      this.onTapUp,
      this.onTapDown,
      this.child,
      this.splashColor,
      this.focusColor,
      this.decoration,
      this.padding});

  final void Function()? onTap;
  final void Function()? onTapCancel;
  final void Function(TapUpDetails d)? onTapUp;
  final void Function(TapDownDetails d)? onTapDown;

  final Widget? child;
  final Color? splashColor;
  final Color? focusColor;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    // decoration.borderRadius = BorderRadius.all(Radius.circular(15));
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTapDown: onTapDown, onTapUp: onTapUp, onTapCancel: onTapCancel,
          // highlightColor: Colors.transparent,

          focusColor: focusColor ?? Colors.transparent,
          splashColor: splashColor ?? const Color.fromARGB(48, 158, 158, 158),
          onTap: onTap ?? () {},
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Container(
              decoration: decoration,
              padding: padding ?? const EdgeInsets.all(15),
              child: child),
        ));
  }
}
