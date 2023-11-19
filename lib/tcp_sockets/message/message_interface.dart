import 'dart:convert';

import 'package:chat_app_dart/tcp_sockets/message/message_reflector.dart';
import 'package:chat_app_dart/tcp_sockets/message/types.dart';
import 'package:reflectable/reflectable.dart';

@MessageReflector()
abstract class IMessage {
  IMessage();
  Map<String, String> toMap();
  IMessage.fromMap(Map<String, String> map);
  String toJSON();
  IMessage.fromJSON(String json);

  // T getType<T extends IMessage>(T type);
  // Type type;

  static ClassMirror? ClassMirrorByName(String name) {
    dynamic type = types[name];
    print("type is --> ");
    print(type);
    if (type == null) {
      return null;
    }

    var typeMirror = const MessageReflector().reflectType(type) as ClassMirror;

    return typeMirror;
  }

  static IMessage? instanceByJson(String json) {
    Map<String, dynamic> jsonMap = jsonDecode(json);
    String? typeName = jsonMap["type"];
    if (typeName == null) {
      return null;
    }
    ClassMirror? mirror = IMessage.ClassMirrorByName(typeName);
    IMessage? instance = mirror?.newInstance("fromJSON", [json]) as IMessage;

    return instance;
  }
}
