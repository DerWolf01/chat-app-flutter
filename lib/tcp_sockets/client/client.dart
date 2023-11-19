import 'dart:async';
import 'dart:io';

import 'package:chat_app_dart/tcp_sockets/message/message_interface.dart';
import 'package:chat_app_dart/tcp_sockets/message/response/server_response.dart';
import 'package:chat_app_dart/tcp_sockets/message/response/sign_up_response.dart';
import 'package:chat_app_dart/tcp_sockets/server/server.dart';
import 'package:chat_app_dart/tcp_sockets/tcp_socket.dart';
import 'package:chat_app_dart/utils/user_session.dart';
import 'package:flutter/material.dart';

class TCPClient extends TCPSocket {
  TCPClient._internal(super._socket);
  static TCPClient? _instance;
  static Future<TCPClient> connect() async {
    if (_instance == null) {
      _instance = TCPClient._internal(
          await Socket.connect(TCPServer.hostname, TCPServer.port));

      _instance!.listen();
    }
    return _instance!;
  }

  @override
  FutureOr<void> listener(String message) {
    print(message);
    var responseInstance = IMessage.instanceByJson(message);
    print(responseInstance);
    if (responseInstance is! ServerResponse) {
      return null;
    }

    if (responseInstance is SignUpResponse) {
      responseInstance = responseInstance as SignUpResponse;
      UserSession.create().token.value = responseInstance.token;
      print(
          'client got:  valid --> ${responseInstance.valid}\n message --> ${responseInstance.message}');
    }
  }
}
