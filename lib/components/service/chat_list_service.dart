import 'package:chat_app_dart/components/chat/chat_list.dart';
import 'package:chat_app_dart/components/chat/chat_model.dart';
import 'package:chat_app_dart/components/service/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListService {
  Future<TChatList?> getChats() async {
    TChatList chatList = [];
    for (var e in (await FirebaseFirestore.instance
            .collection("/chats")
            .where("participants", arrayContains: UserService().activeUser?.id)
            .get())
        .docs) {
      chatList.add(ChatModel.fromMap(e.data()));
      continue;
    }
    return chatList;
  }
}
