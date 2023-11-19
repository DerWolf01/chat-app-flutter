import 'package:flutter/material.dart';

class ShadowDecoration extends BoxDecoration {
  ShadowDecoration()
      : super(
            borderRadius: const BorderRadius.all(Radius.circular(11)),
            color: Colors.white,
            boxShadow: [
              const BoxShadow(
                color: Color.fromARGB(052, 0, 0, 0),
                blurRadius: 25,
              )
            ]);
}
