import 'package:flutter/material.dart';

class UserSession {
  UserSession._internal({String? token}) : token = ValueNotifier(token ?? "");
  static UserSession? _instance;
  static UserSession create({String? token}) {
    _instance ??= UserSession._internal(token: token);
    return _instance!;
  }

  ValueNotifier<String> token;
}
