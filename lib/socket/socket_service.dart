import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:advanced_change_notifier/advanced_change_notifier.dart';
import 'package:chat_app_dart/chat/message/message_model.dart';
import 'package:chat_app_dart/chat/service/chat_service.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/socket/message/active_user_message.dart';
import 'package:chat_app_dart/socket/message/register_message.dart';
import 'package:chat_app_dart/socket/message/socket_message.dart';

class SocketService extends AdvancedChangeNotifier<SocketMessage> {
  Socket? _socket;
  ChatService get chatService => getIt<ChatService>();
  final List<int> existingMessages = [];
  Future connect() async {
    _socket =
        await Socket.connect(Platform.isAndroid ? "10.0.2.2" : "0.0.0.0", 3000);
    print("connected to 0.0.0.0:3000");
    _listen();
    return;
  }

  Future<void> registerClient() async {
    await connect();
    send(SocketMessage(RegisterMessage(chatService.activeUserId!)));
    chatService.addListener((value) async {
      print("SocketService got $value from ChatService");
      if (value == null || messageExists(value)) {
        return;
      }
      send(SocketMessage(value));
    });
  }

  _listen() {
    _socket?.listen(
      (event) {
        receive(decode(event));
      },
    );
  }

  receive(Map m) {
    SocketMessage? socketMessage;
    if (m["type"] == "ActiveUserMessage") {
      ActiveUserMessage activeUserMessage = ActiveUserMessage.fromMap(m);
      print(activeUserMessage);
      print("New active user");
      socketMessage = SocketMessage(activeUserMessage);
    }

    if (m["type"] == "Message") {
      print("New active user");
      Message message = Message.fromMap(m);
      socketMessage = SocketMessage(message);
      markMessage(message);
    }
    notifyListeners(value: socketMessage);
  }

  send(SocketMessage message) {
    _socket?.write(encode(message.toMap()));
  }

  String encode(Map map) => json.encode(map);
  Map<String, dynamic> decode(Uint8List event) =>
      json.decode(utf8.decode(event));

  void markMessage(Message m) => existingMessages.add(m.id);
  bool messageExists(Message m) => existingMessages.contains(m.id);
}
