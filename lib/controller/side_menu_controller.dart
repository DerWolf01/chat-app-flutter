import 'dart:async';

import 'package:chat_app_dart/components/ripple_button/fancy_ripple_button.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/utils/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum SideMenuState { halfScreen, fullScreen, noScreen }

class SideMenuController extends ValueNotifier<SideMenuState> {
  final Curve curve = Curves.easeInOutSine;
  final Duration duration = const Duration(milliseconds: 555);

  SideMenuController() : super(SideMenuState.noScreen);

  halfScreen() {
    value = SideMenuState.halfScreen;
  }

  fullScreen() {
    value = SideMenuState.fullScreen;
  }

  noScreen() {
    value = SideMenuState.noScreen;
  }

  triggerHalfScreen() => value == SideMenuState.noScreen
      ? value = SideMenuState.halfScreen
      : value = SideMenuState.noScreen;
  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

class ContentBase extends StatefulWidget {
  const ContentBase({required this.builder, super.key});
  @override
  State<StatefulWidget> createState() => _ContentBaseState();

  final Widget Function(BuildContext context, SideMenuState) builder;
}

class _ContentBaseState extends State<ContentBase> {
  @override
  void initState() {
    super.initState();
  }

  Matrix4 getTranslationValues(BuildContext context, SideMenuState state) {
    if (state == SideMenuState.halfScreen) {
      return Matrix4.translationValues(
          MediaQuery.sizeOf(context).width * 0.65, 0, 0);
    } else if (state == SideMenuState.fullScreen) {
      return Matrix4.translationValues(MediaQuery.sizeOf(context).width, 0, 0);
    }

    return Matrix4.translationValues(0, 0, 0);
  }

  final SideMenuController sideMenuController = getIt<SideMenuController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: sideMenuController,
        builder: (context, state, child) => AnimatedScale(
            scale: state == SideMenuState.noScreen ? 1.0 : 0.85,
            curve: sideMenuController.curve,
            duration: sideMenuController.duration,
            child: AnimatedContainer(
                transform: getTranslationValues(context, state),
                duration: sideMenuController.duration,
                curve: sideMenuController.curve,
                decoration: ShadowDecoration(
                    borderRadius: state != SideMenuState.noScreen ? 35 : 0),
                child: widget.builder(context, state))));
  }
}

class SideMenuBase extends StatefulWidget {
  const SideMenuBase({required this.builder, super.key});
  @override
  State<StatefulWidget> createState() => _SideMenuBaseState();

  final Widget Function(BuildContext context, SideMenuState) builder;
}

class _SideMenuBaseState extends State<SideMenuBase> {
  @override
  void initState() {
    super.initState();
  }

  final SideMenuController sideMenuController = getIt<SideMenuController>();
  ValueNotifier<double> width = ValueNotifier(205);
  Matrix4 getTranslationValues(BuildContext context, SideMenuState state) {
    if (state == SideMenuState.halfScreen) {
      return Matrix4.translationValues(
          ((width.value / MediaQuery.sizeOf(context).width) *
                  MediaQuery.sizeOf(context).width) *
              0.01,
          0,
          0);
    } else if (state == SideMenuState.fullScreen) {
      return Matrix4.translationValues(0, 0, 0);
    }

    return Matrix4.translationValues(-MediaQuery.sizeOf(context).width, 0, 0);
  }

  double getScale(SideMenuState state) {
    if (state == SideMenuState.halfScreen) {
      return 0.85;
    } else if (state == SideMenuState.fullScreen) {
      return 1.0;
    }

    return 0.5;
  }

  double getWidth(BuildContext context, SideMenuState state) {
    if (state == SideMenuState.fullScreen) {
      return MediaQuery.sizeOf(context).width;
    }

    return 205;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: sideMenuController,
        builder: (context, state, child) => AnimatedContainer(
            transform: getTranslationValues(context, state),
            duration: sideMenuController.duration,
            curve: sideMenuController.curve,
            decoration: ShadowDecoration(),
            width: getWidth(context, state),
            child: Row(
                children: [Expanded(child: widget.builder(context, state))])));
  }
}

class SideMenuTrigger extends GestureDetector {
  SideMenuTrigger({super.child, Future<void> Function()? onTap, super.key})
      : super(onTap: () {
          getIt<SideMenuController>().triggerHalfScreen();
          if (onTap != null) {
            onTap();
          }
        });
}

class FancySideMenuTrigger extends FancyRippleButton {
  FancySideMenuTrigger({super.child, Future<void> Function()? onTap, super.key})
      : super(onTap: () {
          getIt<SideMenuController>().triggerHalfScreen();
          if (onTap != null) {
            onTap();
          }
        });
}
