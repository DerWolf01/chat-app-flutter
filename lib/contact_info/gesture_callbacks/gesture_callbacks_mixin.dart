import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/side_menu/controller/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

mixin class ContactInfoWidgetGestureConfig {
  Duration get duration => getIt<SideMenuController>().duration;
  final ValueNotifier<double?> width = ValueNotifier(null);
  final ValueNotifier<double?> height = ValueNotifier(null);
  final ValueNotifier<double> x = ValueNotifier(0.0);
  final ValueNotifier<double> y = ValueNotifier(0.0);
  final ValueNotifier<bool> dragging = ValueNotifier(false);
  final ValueNotifier<bool> active = ValueNotifier(false);

  ValueNotifier<double> actualProgress = ValueNotifier(0.0);
  double getProgress(double translationY) {
    actualProgress.value = translationY / (viewHeight);
    if (actualProgress.value < 0) {
      actualProgress.value = 0;
    }
    return actualProgress.value;
  }

  late double viewHeight;

  double viewWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width - 50;

  double widthByProgress(BuildContext context, double progress) =>
      ((viewWidth(context) - 255) * progress);
}
