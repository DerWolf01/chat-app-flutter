import 'package:chat_app_dart/components/chat/chat_model.dart';
import 'package:chat_app_dart/components/ripple_button/fancy_ripple_button.dart';
import 'package:chat_app_dart/components/service/chat_list_service.dart';
import 'package:chat_app_dart/components/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/components/ripple_button/expanded_ripple.dart';

typedef TChatList = List<ChatModel>;

class ChatList extends StatelessWidget {
  ChatList({super.key});

  final TChatList chatList = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ChatListService().getChats(),
      builder: (context, snapshot) {
        return Column(children: [
          Container(
              padding: const EdgeInsets.all(15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FancyRippleButton(
                    child: Icon(Icons.add),
                  )
                ],
              )),
          snapshot.data == null || snapshot.data?.isEmpty == true
              ? Expanded(
                  child: Container(
                      child: const Center(child: Text("No Chats yet"))))
              : Column(
                  children: snapshot.data!
                      .map(
                        (e) => ExpandedRipple(
                          child: Text(e.participants
                              .where(
                                (element) =>
                                    element !=
                                    UserService().activeUser?.mobileNumber,
                              )
                              .first),
                        ),
                      )
                      .toList())
        ]);
      },
    );
  }
}
