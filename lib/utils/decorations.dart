import 'package:flutter/material.dart';

class ShadowDecoration extends BoxDecoration {
  ShadowDecoration({double? borderRadius})
      : super(
            borderRadius: BorderRadius.circular(borderRadius ?? 11),
            color: Colors.white,
            boxShadow: [
              const BoxShadow(
                color: Color.fromARGB(052, 0, 0, 0),
                blurRadius: 25,
              )
            ]);
}
