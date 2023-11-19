import 'package:chat_app_dart/components/form_components/decorators/data.dart';
import 'package:chat_app_dart/components/form_components/decorators/max_length.dart';
import 'package:chat_app_dart/components/form_components/decorators/min_length.dart';
import 'package:chat_app_dart/components/form_components/decorators/pattern.dart';
import 'package:chat_app_dart/tcp_sockets/message/message_interface.dart';
import 'dart:convert';

import 'package:chat_app_dart/tcp_sockets/message/message_reflector.dart';

const messageReflector = MessageReflector();

@messageReflector
class SignUp implements IMessage {
  SignUp(this.username, this.password);

  SignUp.fromMap(Map<String, dynamic> map)
      : username = map["username"],
        password = map["password"];

  @override
  Map<String, String> toMap() {
    return {"type": "SignUp", "username": username, "password": password};
  }

  @MinLength(3)
  @MaxLength(15)
  String username;
  @MinLength(7)
  @MaxLength(15)
  @Pattern("[A-Z]", "Only lettter!")
  String password;

  SignUp.fromJSON(String json)
      : username = SignUp.fromMap(jsonDecode(json)).username,
        password = SignUp.fromMap(jsonDecode(json)).password;

  @override
  String toJSON() {
    return jsonEncode(toMap());
  }
}
