import 'package:chat_app_dart/chat/message/message_model.dart';
import 'package:chat_app_dart/chat/service/chat_service.dart';
import 'package:chat_app_dart/contact_info/contact_info_widget.dart';
import 'package:chat_app_dart/side_menu/controller/side_menu_controller.dart';
import 'package:chat_app_dart/chat/user/model/user_model.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/chat/widget/chat_input.dart';
import 'package:chat_app_dart/chat/message/widget/chat_messages.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat(this.state, {super.key});
  final SideMenuState state;

  @override
  State<StatefulWidget> createState() => ChatState();
}

class ChatState extends State<Chat> {
  User? chosenContact;
  ChatService chatService = getIt<ChatService>();
  @override
  void initState() {
    super.initState();
    chatService.addListener(
      chatServiceListener,
    );
  }

  Future<void> chatServiceListener(Message? value) async {
    setState(() {
      chosenContact = chatService.chosenContact;
    });
  }

  @override
  void dispose() {
    super.dispose();
    chatService.removeListener(chatServiceListener);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
        child: Stack(
            alignment: Alignment.topCenter,
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Column(children: [
                    Expanded(
                        child: Container(
                            decoration: const BoxDecoration(),
                            clipBehavior: Clip.antiAlias,
                            child: ChatMessages(chosenContact))),
                    const Divider(
                      height: 25.0,
                      color: Colors.transparent,
                    ),
                    SizedBox(height: 55, child: ChatInput())
                  ])),
                ],
              ),
              Positioned(
                  width: MediaQuery.sizeOf(context).width,
                  top: 15,
                  child: Container(
                      decoration: const BoxDecoration(),
                      child: ChatToolbar(widget.state, chosenContact))),
            ]));
  }
}

class ChatToolbar extends StatelessWidget {
  const ChatToolbar(this.state, this.chosenContact, {super.key});
  final User? chosenContact;
  final SideMenuState state;

  final Radius radius = const Radius.circular(9);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topLeft, children: [
      Container(
          transform: Matrix4.translationValues(35, 0, 0),
          child: FancySideMenuTrigger(
            child: state == SideMenuState.noScreen
                ? const Icon(Icons.menu_rounded)
                : const Icon(Icons.arrow_back_rounded),
          )),
      const VerticalDivider(
        width: 25,
        color: Colors.transparent,
      ),
      ContactInfoWidget()
    ]);
  }
}
