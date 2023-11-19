import 'dart:async';
import 'dart:io';
import 'package:chat_app_dart/tcp_sockets/message/message_interface.dart';
import 'package:chat_app_dart/tcp_sockets/message/response/sign_up_response.dart';
import 'package:chat_app_dart/tcp_sockets/message/sign_up.dart';
import 'package:chat_app_dart/tcp_sockets/tcp_socket.dart';

class TCPSocketClientHandler extends TCPSocket {
  TCPSocketClientHandler._internal(super._socket);

  static TCPSocketClientHandler createClientHandler(Socket socket) {
    TCPSocketClientHandler instance = TCPSocketClientHandler._internal(socket);
    instance.listen();
    return instance;
  }

  @override
  FutureOr<void> listener(String message) {
    print("client-handler got $message");

    var instance = IMessage.instanceByJson(message);

    if (instance is SignUp) {
      write(SignUpResponse("asfdaefase", true, "Succesfully Signed Up!"));
    }
  }
}
