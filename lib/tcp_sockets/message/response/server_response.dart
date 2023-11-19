import 'dart:convert';

import 'package:chat_app_dart/tcp_sockets/message/message_interface.dart';
import 'package:chat_app_dart/tcp_sockets/message/message_reflector.dart';

const messageReflector = MessageReflector();

@messageReflector
class ServerResponse extends IMessage {
  ServerResponse(this.valid, this.message);
  ServerResponse.fromMap(Map<String, dynamic> map)
      : message = map["message"],
        valid = map["valid"] == "true";
  ServerResponse.fromJSON(String json)
      : message = ServerResponse.fromMap(jsonDecode(json)).message,
        valid = ServerResponse.fromMap(jsonDecode(json)).valid;
  @override
  String toJSON() {
    return jsonEncode(toMap());
  }

  @override
  Map<String, String> toMap() {
    return {
      "type": runtimeType.toString(),
      "valid": valid.toString(),
      "message": message
    };
  }

  bool valid;
  String message;
}
