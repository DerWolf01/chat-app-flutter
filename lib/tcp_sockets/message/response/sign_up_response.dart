import 'dart:convert';

import 'package:chat_app_dart/tcp_sockets/message/message_reflector.dart';
import 'package:chat_app_dart/tcp_sockets/message/response/server_response.dart';

const messageReflector = MessageReflector();

@messageReflector
class SignUpResponse extends ServerResponse {
  SignUpResponse(this.token, super.valid, super.message);
  @override
  Map<String, String> toMap() {
    var res = super.toMap();

    res["token"] = token;
    return res;
  }

  @override
  SignUpResponse.fromMap(Map<String, dynamic> map)
      : token = map["token"],
        super.fromMap(map);
  @override
  String toJSON() => jsonEncode(toMap());
  SignUpResponse.fromJSON(String json)
      : token = SignUpResponse.fromMap(jsonDecode(json)).token,
        super.fromJSON(json);

  String token;
}
