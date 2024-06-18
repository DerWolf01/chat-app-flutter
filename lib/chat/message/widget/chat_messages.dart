import 'dart:async';
import 'package:chat_app_dart/chat/message/message_model.dart';
import 'package:chat_app_dart/chat/message/widget/contact_message.dart';
import 'package:chat_app_dart/chat/message/widget/user_message.dart';
import 'package:chat_app_dart/chat/service/chat_service.dart';
import 'package:chat_app_dart/chat/user/model/user_model.dart';
import 'package:chat_app_dart/chat/user/service/user_service.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages(this.chosenContact, {super.key});
  final Radius radius = const Radius.circular(9);
  final User? chosenContact;

  @override
  State<StatefulWidget> createState() => ChatMessagesState();
}

class ChatMessagesState extends State<ChatMessages> {
  final ChatService chatService = getIt<ChatService>();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();

    chatService.addListChangeListener(
      (List<Message>? value) async {
        if (value == null) {
          return;
        }
        setState(() {
          messages.clear();
          messages.addAll(value);
        });

        controller =
            ScrollController(initialScrollOffset: messages.length * 15);
      },
    );
    chatService.addListener(
      (Message? value) async {
        if (value == null) {
          return;
        }
        setState(() {
          messages.add(value);
        });

        controller.animateTo(controller.offset + 115,
            duration: const Duration(milliseconds: 255),
            curve: Curves.easeInOut);
      },
    );
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Timer.periodic(
    //   Duration(seconds: 5),
    //   (timer) async {
    //     await chatService.syncMessages();
    //   },
    // );
    return messages.isNotEmpty
        ? ListView(
            controller: controller,
            children: messages
                .map((m) => Column(children: [
                      m.sender == getIt<UserService>().activeUser?.id
                          ? UserMessage(m)
                          : ContactMessage(m),
                      const Divider(
                        color: Colors.transparent,
                      )
                    ]))
                .toList(),
          )
        // Scroller(Column(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: messages
        //         .map((m) => Column(children: [
        //               m.sender == getIt<UserService>().activeUser?.id
        //                   ? UserMessage(m)
        //                   : ContactMessage(m),
        //               const Divider(
        //                 color: Colors.transparent,
        //               )
        //             ]))
        //         .toList(),
        //     // ContactMessage(),
        //   ))
        : Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Make the first step ",
              style: TextStyle(color: Colors.grey),
            ),
            // SvgPicture.asset("assets/empty_chat.svg")
          ]));
  }
}
