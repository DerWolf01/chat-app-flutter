import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  const RippleButton(
      {super.key,
      this.onTap,
      this.child,
      this.splashColor,
      this.focusColor,
      this.decoration,
      this.padding});

  final void Function()? onTap;
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
