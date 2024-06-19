import 'dart:async';

import 'package:advanced_change_notifier/advanced_change_notifier.dart';
import 'package:chat_app_dart/ripple_button/fancy_ripple_button.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/utils/decorations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef AnimationValueGenerator<T> = T Function(BuildContext context);
typedef AnimationValueGeneratorWithProgress<T> = T Function(
    BuildContext context, double progress);

class AnimationStop<KeyType> {
  const AnimationStop(
      {required this.key, required this.x, required this.scale, this.width});
  final KeyType key;
  final AnimationValueGenerator<double> x;
  // final AnimationValueGenerator? y;
  // final AnimationValueGenerator? z;
  final AnimationValueGeneratorWithProgress<double> scale;
  final AnimationValueGenerator<double?>? width;
}

class AnimationStops<KeyType> {
  AnimationStops(this.actualStopKey, this.stop1, this.stop2, this.stop3);

  KeyType actualStopKey;
  final AnimationStop<KeyType> stop1;
  final AnimationStop<KeyType> stop2;
  final AnimationStop<KeyType> stop3;

  List<AnimationStop<KeyType>> get stops => [stop1, stop2, stop3];

  void setNextStop() => actualStopKey = nextStop().key;
  AnimationStop actualStop() => byKey(actualStopKey);
  AnimationStop nextStop() {
    var active = indexbyKey(actualStopKey);

    if (stops.length - 1 == active) {
      return stops[0];
    }

    return stops.elementAt(active + 1);
  }

  int indexbyKey(KeyType key) {
    int index = 0;
    for (var s in stops) {
      if (s.key == key) {
        break;
      }
      index++;
    }
    return index;
  }

  byKey(KeyType key) {
    var res = stops
        .where(
          (element) => element.key == key,
        )
        .first;

    return res;
  }
}

typedef ProgressListener = void Function(double progress);
typedef StateListener = void Function(SideMenuState newX);

class SideMenuControllerChangeNotifier
    with AdvancedChangeNotifier<SideMenuState> {
  final ValueNotifier<double> _progress = ValueNotifier(0.0);
  final ValueNotifier<SideMenuState> _state =
      ValueNotifier(SideMenuState.noScreen);
  final ValueNotifier<bool> _dragging = ValueNotifier(false);

  final Curve curve = Curves.easeInOutSine;
  final Duration duration = const Duration(milliseconds: 555);

  Matrix4 translationValues(
      BuildContext context, double progress, AnimationStops stops) {
    var actual = stops.actualStop();
    var actualX = actual.x(context);

    var next = stops.nextStop();
    var nextX = next.x(context);

    double diff = 0;
    late double res;
    if (actualX.isNegative) {
      diff = nextX - actualX.abs() * progress;
      res = actualX - diff;
    } else {
      res = (nextX - actualX).abs() * progress;
    }

    return Matrix4.translationValues(res, 0, 0);
  }

  double getScale(BuildContext context, double progress, AnimationStops stops) {
    var fScale = stops.actualStop().scale(context, progress);
    var sScale = stops.nextStop().scale(context, progress);
    return fScale - (fScale - sScale) * progress;
  }

  Widget listenableBuilder(
      {required Type key,
      required Widget Function(
              double progress, bool dragging, SideMenuState state)
          builder,
      required AnimationStops<SideMenuState> stops}) {
    return Builder(builder: (context) {
      double x = stops.actualStop().x(context);
      var nextStopX = stops.nextStop().x(context);

      return GestureDetector(
          key: Key(key.toString()),
          onHorizontalDragStart: (details) {
            start();
          },
          onHorizontalDragUpdate: (details) {
            if ((x + details.delta.dx) / nextStopX >= 0.997) {
              return;
              print("previous stop was ${stops.actualStopKey} $key");
              print("stop x was ${stops.actualStop().x(context)}");
              stops.setNextStop();
              x = stops.byKey(stops.actualStopKey).x(context);
              nextStopX = stops.nextStop().x(context);
              print("set next stop ${stops.actualStopKey} $key");
              print("stop x now is ${stops.actualStop().x(context)}");

              _state.value = stops.actualStopKey;
              _progress.value = x / nextStopX;
            }
            x += details.delta.dx;
            updateProgress(x / nextStopX);
          },
          onHorizontalDragEnd: (details) {
            done();
            if (_progress.value > 0.11) {
              print("previous stop was ${stops.actualStopKey} $key");
              print("stop x was ${stops.actualStop().x(context)}");
              stops.setNextStop();
              x = stops.byKey(stops.actualStopKey).x(context);
              nextStopX = stops.nextStop().x(context);
              print("set next stop ${stops.actualStopKey} $key");
              print("stop x now is ${stops.actualStop().x(context)}");

              _state.value = stops.actualStopKey;
              _progress.value = x / nextStopX;
              _progress.value = 1.0;
            } else {
              _progress.value = 0.0;
            }
          },
          child: ValueListenableBuilder(
            key: Key(key.toString()),
            valueListenable: _dragging,
            builder: (context, dragging, child) => ValueListenableBuilder(
                key: Key(key.toString()),
                valueListenable: _progress,
                builder: (context, progress, child) => ValueListenableBuilder(
                    key: Key(key.toString()),
                    valueListenable: _state,
                    builder: (context, state, child) {
                      return AnimatedScale(
                          scale: getScale(context, progress, stops),
                          duration: dragging ? Duration.zero : duration,
                          child: AnimatedContainer(
                              key: Key(key.toString()),
                              width: stops.byKey(state).width != null
                                  ? stops.byKey(state).width(context)
                                  : null,
                              transform:
                                  translationValues(context, progress, stops),
                              duration: dragging ? Duration.zero : duration,
                              curve: curve,
                              decoration: ShadowDecoration(),
                              // width: getWidth(context, state),
                              child: builder(progress, dragging, state)));
                    })),
          ));
    });
  }

  void start() {
    _dragging.value = true;
  }

  void done() {
    _dragging.value = false;
  }

  void updateProgress(double progress) {
    _progress.value = progress;
  }

  // final Map<String, ProgressListener> _progressListeners = {};
  // final Map<String, StateListener> _stateListeners = {};

  // notifyProgressListeners(double progress) {
  //   for (var l in _progressListeners.values) {
  //     l(progress);
  //   }
  // }

  // notifyStateChangeListeners(SideMenuState state) {
  //   for (var l in _stateListeners.values) {
  //     l(state);
  //   }
  // }

  // addProgressListener(String key, ProgressListener l) =>
  //     _progressListeners[key] = l;
  // addStateChangeListener(String key, StateListener l) =>
  //     _stateListeners[key] = l;
}

enum SideMenuState { halfScreen, fullScreen, noScreen }

class SideMenuController extends SideMenuControllerChangeNotifier {
  SideMenuController();

  moveX(double x) {}

  halfScreen() {
    _state.value = SideMenuState.halfScreen;
  }

  fullScreen() {
    _state.value = SideMenuState.fullScreen;
  }

  noScreen() {
    _state.value = SideMenuState.noScreen;
  }

  triggerHalfScreen() => _state.value == SideMenuState.noScreen
      ? _state.value = SideMenuState.halfScreen
      : _state.value = SideMenuState.noScreen;
}

extension ContentBaseFactos on SideMenuState {
  double xFactor() {
    if (this == SideMenuState.halfScreen) {
      return 0.65;
    } else if (this == SideMenuState.fullScreen) {
      return 1.0;
    }
    return 0.0;
  }
}

class ContentBase extends StatelessWidget {
  ContentBase({required this.builder, super.key});

  final Widget Function(BuildContext context, SideMenuState) builder;

  final ValueNotifier<double> _x = ValueNotifier(0.0);
  final ValueNotifier<double> _scale = ValueNotifier(1.0);
  final ValueNotifier<bool> _dragging = ValueNotifier(false);

  Matrix4 getTranslationValues(BuildContext context, SideMenuState state) {
    if (state == SideMenuState.halfScreen) {
      return Matrix4.translationValues(halfScreenX(context), 0, 0);
    } else if (state == SideMenuState.fullScreen) {
      return Matrix4.translationValues(MediaQuery.sizeOf(context).width, 0, 0);
    }

    return Matrix4.translationValues(0, 0, 0);
  }

  final SideMenuController sideMenuController = getIt<SideMenuController>();

  double halfScreenX(BuildContext context) =>
      MediaQuery.sizeOf(context).width * 0.65;

  double getProgress(double x, BuildContext context) =>
      x / halfScreenX(context);

  AnimationStops<SideMenuState> get stops => AnimationStops(
        SideMenuState.noScreen,
        AnimationStop(
          key: SideMenuState.noScreen,
          x: (context) => 0.0,
          width: (context) => MediaQuery.sizeOf(context).width,
          scale: (context, p) => 1.0,
        ),
        AnimationStop(
            key: SideMenuState.halfScreen,
            x: (context) => halfScreenX(context),
            width: (context) => MediaQuery.sizeOf(context).width,
            scale: (context, p) => 1.0 - (p * 0.25)),
        AnimationStop(
            key: SideMenuState.fullScreen,
            x: (context) => MediaQuery.sizeOf(context).width,
            width: (context) => MediaQuery.sizeOf(context).width,
            scale: (context, p) => 1.0 - (p * 0.25)),
      );
  @override
  Widget build(BuildContext context) {
    return sideMenuController.listenableBuilder(
        key: runtimeType,
        stops: stops,
        builder: (progress, dragging, state) =>
            //  AnimatedScale(
            //     // scale: state == SideMenuState.noScreen ? 1.0 : 0.85,
            //     // scale: 1.0 - ((getProgress(x, context)) * 0.25),
            //     curve: sideMenuController.curve,
            //     duration: dragging ? Duration.zero : sideMenuController.duration,
            //     child:
            // AnimatedContainer(
            //     // transform: getTranslationValues(context, state),
            //     // transform: Matrix4.translationValues(x, 0, 0),
            //     duration:
            //         dragging ? Duration.zero : sideMenuController.duration,
            //     curve: sideMenuController.curve,
            //     decoration: ShadowDecoration(
            //         borderRadius: state != SideMenuState.noScreen ? 35 : 0),
            //     child:
            builder(context, state));

    // ));
  }
}

class SideMenuBase extends StatelessWidget {
  SideMenuBase({required this.builder, super.key});
  final Widget Function(BuildContext context, SideMenuState) builder;

  final SideMenuController sideMenuController = getIt<SideMenuController>();
  final ValueNotifier<double> width = ValueNotifier(205);
  Matrix4 getTranslationValues(BuildContext context, SideMenuState state) {
    if (state == SideMenuState.halfScreen) {
      return Matrix4.translationValues(
          -((width.value / MediaQuery.sizeOf(context).width) *
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

  AnimationStops<SideMenuState> get stops => AnimationStops<SideMenuState>(
      SideMenuState.noScreen,
      AnimationStop(
        key: SideMenuState.noScreen,
        width: (context) => 205,
        x: (context) => -MediaQuery.sizeOf(context).width,
        scale: (context, p) => 1.0 - (p * 0.25),
      ),
      AnimationStop(
        key: SideMenuState.halfScreen,
        width: (context) => 205,
        x: (context) =>
            -((width.value / MediaQuery.sizeOf(context).width) *
                MediaQuery.sizeOf(context).width) *
            0.01,
        scale: (context, p) => 1.0,
      ),
      AnimationStop(
        key: SideMenuState.fullScreen,
        width: (context) => MediaQuery.sizeOf(context).width,
        x: (context) => 0.0,
        scale: (context, p) => 1.0,
      ));
  @override
  Widget build(BuildContext context) {
    return sideMenuController.listenableBuilder(
        key: runtimeType,
        builder: (progress, dragging, state) => Container(
            color: Colors.black,
            child: builder(context, SideMenuState.halfScreen)),
        stops: stops);
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
