import 'dart:async';

import 'package:chat_app_dart/components/ripple_button/fancy_ripple_button.dart';
import 'package:chat_app_dart/utils/decorations.dart';
import 'package:flutter/material.dart';

enum SideMenuState { halfScreen, fullScreen, noScreen }

class SideMenuController extends ValueNotifier<SideMenuState> {
  SideMenuController._internal() : super(SideMenuState.noScreen);

  static SideMenuController? _instance;

  factory SideMenuController() {
    _instance ??= SideMenuController._internal();
    return _instance!;
  }

  halfScreen() {
    value = SideMenuState.halfScreen;
  }

  fullScreen() {
    value = SideMenuState.fullScreen;
  }

  noScreen() {
    value = SideMenuState.noScreen;
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

class ContentBase extends StatefulWidget {
  const ContentBase({required this.child, super.key});
  @override
  State<StatefulWidget> createState() => _ContentBaseState();

  final Widget child;
}

class _ContentBaseState extends State<ContentBase> {
  @override
  void initState() {
    super.initState();
  }

  Matrix4 getTranslationValues(BuildContext context, SideMenuState state) {
    if (state == SideMenuState.halfScreen) {
      return Matrix4.translationValues(
          MediaQuery.sizeOf(context).width / 2, 0, 0);
    } else if (state == SideMenuState.fullScreen) {
      return Matrix4.translationValues(MediaQuery.sizeOf(context).width, 0, 0);
    }

    return Matrix4.translationValues(0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: SideMenuController(),
        builder: (context, state, child) => AnimatedScale(
            scale: state == SideMenuState.noScreen ? 1.0 : 0.85,
            curve: Curves.elasticOut,
            duration: const Duration(milliseconds: 1333),
            child: AnimatedContainer(
                transform: getTranslationValues(context, state),
                duration: const Duration(milliseconds: 1333),
                curve: Curves.elasticOut,
                decoration: ShadowDecoration(
                    borderRadius: state != SideMenuState.noScreen ? 35 : 0),
                child: widget.child)));
  }
}

class SideMenuBase extends StatefulWidget {
  const SideMenuBase({required this.child, super.key});
  @override
  State<StatefulWidget> createState() => _SideMenuBaseState();

  final Widget child;
}

class _SideMenuBaseState extends State<SideMenuBase> {
  @override
  void initState() {
    super.initState();
  }

  final double width = 205;
  Matrix4 getTranslationValues(BuildContext context, SideMenuState state) {
    if (state == SideMenuState.halfScreen) {
      return Matrix4.translationValues(-width, 0, 0);
    } else if (state == SideMenuState.fullScreen) {
      return Matrix4.translationValues(0, 0, 0);
    }

    return Matrix4.translationValues(-MediaQuery.sizeOf(context).width, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: SideMenuController(),
        builder: (context, state, child) => AnimatedContainer(
            transform: getTranslationValues(context, state),
            duration: const Duration(milliseconds: 1333),
            curve: Curves.elasticOut,
            decoration: ShadowDecoration(),
            width: width,
            child: Row(children: [Expanded(child: widget.child)])));
  }
}

class SideMenuTrigger extends GestureDetector {
  SideMenuTrigger({super.child, Future<void> Function()? onTap, super.key})
      : super(onTap: () {
          SideMenuController().halfScreen();
          if (onTap != null) {
            onTap();
          }
        });
}

class FancySideMenuTrigger extends FancyRippleButton {
  FancySideMenuTrigger({super.child, Future<void> Function()? onTap, super.key})
      : super(onTap: () {
          SideMenuController().halfScreen();
          if (onTap != null) {
            onTap();
          }
        });
}
