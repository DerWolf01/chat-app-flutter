import 'package:chat_app_dart/chat/service/chat_service.dart';
import 'package:chat_app_dart/chat/widget/chat_list.dart';
import 'package:chat_app_dart/chat/model/chat_model.dart';
import 'package:chat_app_dart/chat/user/service/user_service.dart';
import 'package:chat_app_dart/firestore/firestore.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListService extends ChangeNotifier {
  UserService userService = getIt<UserService>();
  ChatService chatService = getIt<ChatService>();
  int? get activeUserId => userService.activeUser?.id;
  int? get chosenContactId => chatService.chosenContact?.id;
  TChatList chatList = [];
  Future<TChatList?> getChats() async {
    TChatList chatList = [];
    for (var e in ((await getDocs("/chats")).where(
      (element) =>
          (element.data()["participants"] as List?)?.contains(activeUserId) ??
          false,
    ))) {
      var data = e.data();

      data["participants"] = data["participants"]
          .map<int>((e) => int.parse(e.toString()))
          .toList();
      chatList.add(ChatModel.fromMap(data));
      continue;
    }
    this.chatList = chatList;
    notifyListeners();
    return chatList;
  }
}

extension on List {
  List<int> toIntegerList() =>
      map<int>((e) => int.parse(e.toString())).toList();
}
