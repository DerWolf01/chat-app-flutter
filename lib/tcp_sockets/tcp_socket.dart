import 'dart:async';
import 'dart:io';

import 'package:chat_app_dart/tcp_sockets/message/message_interface.dart';
import 'package:flutter/services.dart';

abstract class TCPSocket {
  const TCPSocket(this.socket);

  final Socket socket;

  Future<dynamic> write(IMessage message) async {
    String json = message.toJSON();
    socket.write(json);
  }

  listen() {
    socket.listen((Uint8List data) {
      listener(String.fromCharCodes(data));
    });
  }

  FutureOr<void> listener(String message);
}
