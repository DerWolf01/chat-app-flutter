import 'package:chat_app_dart/tcp_sockets/server/server.dart';
import 'package:flutter/material.dart';
import 'main.reflectable.dart';
import 'package:chat_app_dart/views/main_view.dart';

void main() async {
  //starting the server
  initializeReflectable();

  TCPServer server = await TCPServer.bind();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: Center(child: MainView())));
  }
}
