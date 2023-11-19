import 'dart:io';
import 'dart:typed_data';
import 'package:chat_app_dart/tcp_sockets/message/message_interface.dart';
import 'package:chat_app_dart/tcp_sockets/message/sign_up.dart';
import 'package:chat_app_dart/tcp_sockets/server/client_handler.dart';

class TCPServer {
  TCPServer._internal(this._tcpSocket);
  static Future<TCPServer> bind() async {
    _instance ??= TCPServer._internal(await ServerSocket.bind(hostname, port));
    _instance!.accept();
    return _instance!;
  }

  accept() {
    _tcpSocket.listen((event) {
      handleClient(event);
    });
  }

  List<Socket> clients = List.empty();
  Future<void> handleClient(Socket socket) async {
    TCPSocketClientHandler.createClientHandler(socket);
  }

// socket instance
  late final ServerSocket _tcpSocket;

// server is listening
  bool isListening = true;

  // static fields

  // server settings
  static String hostname = "localhost";
  static int port = 1335;

// global instance, only one server per app
  static TCPServer? _instance;
}
