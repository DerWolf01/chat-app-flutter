import 'dart:convert';
import 'dart:io';
import 'package:chat_app_dart/chat/message/message_model.dart';
import 'package:chat_app_dart/chat/service/chat_service.dart';
import 'package:chat_app_dart/chat/user/model/user_model.dart';
import 'package:chat_app_dart/firestore/model/model.dart';
import 'package:chat_app_dart/get_it/setup.dart';

class SocketMessage<T extends Model> extends Model {
  SocketMessage(this.content);
  T content;
  @override
  Map<String, dynamic> toMap() {
    return {"type": content.runtimeType.toString(), ...content.toMap()};
  }
}

class RegisterMessage extends Model {
  RegisterMessage(this.userId);

  int userId;
  @override
  Map<String, dynamic> toMap() => {"userId": userId};
  RegisterMessage.fromMap(Map map) : userId = map["userId"];
}

class SocketService {
  Socket? _socket;
  ChatService chatService = getIt<ChatService>();

  Future connect() async {
    _socket = await Socket.connect("0.0.0.0", 3000);
    print("connected to 0.0.0.0:3000");
    _listen();
    return;
  }

  Future<void> registerClient() async {
    if (chatService.activeUserId == null) {
      print(chatService.activeUserId);
      print("no user signed in");
      return;
    }
    await connect();
    await sendSocketMessage(
        SocketMessage(RegisterMessage(chatService.activeUserId!)));
  }

  _listen() {
    _socket?.listen(
      (event) {
        print("got ${utf8.decode(event)}");
      },
    );
  }

  sendSocketMessage(SocketMessage m) {
    _socket?.write(json.encode(m.toMap()));
  }

  onSocketMessage(SocketMessage m) {}

  sendMessage(Message m) {
    _socket?.write(json.encode(m.toMap()));
  }

  onMessage(Message m) {}
}
