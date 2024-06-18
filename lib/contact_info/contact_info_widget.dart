import 'package:chat_app_dart/contact_info/gesture_callbacks/gesture_callbacks_mixin.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/side_menu/controller/side_menu_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactInfoWidget extends StatelessWidget
    with ContactInfoWidgetGestureConfig {
  ContactInfoWidget({super.key});

  Widget listenablesBuilder(Widget Function(double? width, double? height, double x, double y, bool dragging, double actualProgress) builder) =>
      ValueListenableBuilder(
          valueListenable: actualProgress,
          builder: (context, actualProgress, child) => ValueListenableBuilder(
              valueListenable: dragging,
              builder: (context, dragging, child) => ValueListenableBuilder(
                  valueListenable: x,
                  builder: (context, x, child) => ValueListenableBuilder(
                      valueListenable: width,
                      builder: (context, width, child) => ValueListenableBuilder(
                          valueListenable: height,
                          builder: (context, height, child) => ValueListenableBuilder(
                              valueListenable: y,
                              builder: (context, y, child) => builder(
                                  width, height, x, y, dragging, actualProgress)))))));

  void showContactInfo(BuildContext context) {
    width.value = MediaQuery.sizeOf(context).width;
    height.value = viewHeight;
    x.value = -115;
    active.value = true;
  }

  void hideContactInfo(BuildContext context) {
    width.value = null;
    height.value = null;
    x.value = 0;
    y.value = 0;
    active.value = false;
  }

  @override
  Widget build(BuildContext context) {
    viewHeight = MediaQuery.sizeOf(context).height;
    return listenablesBuilder(
        (width, height, x, y, dragging, actualProgress) => GestureDetector(
              onVerticalDragEnd: (details) {
                this.dragging.value = false;

                if (actualProgress > 0.055 ||
                    (details.primaryVelocity ?? 0) > 111) {
                  showContactInfo(context);
                } else {
                  actualProgress = 0;
                  hideContactInfo(context);
                }
              },
              onVerticalDragCancel: () {
                this.dragging.value = false;

                if (actualProgress > 0.055) {
                  showContactInfo(context);
                } else {
                  actualProgress = 0;
                  hideContactInfo(context);
                }
              },
              onVerticalDragStart: (details) {
                this.dragging.value = true;
              },
              onTap: () {
                if (height == null) {
                  showContactInfo(context);
                } else {
                  hideContactInfo(context);
                }
              },
              onVerticalDragUpdate: (details) {
                this.y.value += details.delta.dy;
                this.x.value = -(getProgress(y) * 115);
              },
              child: content(
                  width ?? widthByProgress(context, getProgress(y) * 2) + 255,
                  height ?? ((getProgress(y) * (viewHeight - 55)) + 55),
                  x,
                  dragging,
                  actualProgress),
            ));
  }

  Widget content(double width, double height, double x, bool dragging,
          double progress) =>
      AnimatedContainer(
          duration: dragging ? const Duration(milliseconds: 0) : duration,
          transform: Matrix4.translationValues(x + 115, 0, 0),
          width: width,
          height: height,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.11),
                blurRadius: 29,
                offset: const Offset(0, 9))
          ], color: Colors.white, borderRadius: BorderRadius.circular(19)),
          child: Stack(
            children: [
              AnimatedContainer(
                  transform: Matrix4.translationValues(15, 15, 0),
                  duration: duration,
                  child: Text(
                    "Username",
                    style: TextStyle(fontSize: 17),
                  )),
              AnimatedOpacity(
                opacity: progress * 1,
                duration: duration,
                child: Column(
                  children: [Text("Media"), Text("calls")],
                ),
              )
            ],
          ));
}
