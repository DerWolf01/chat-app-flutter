import 'package:chat_app_dart/chat/model/chat_model.dart';
import 'package:chat_app_dart/chat/service/chat_service.dart';
import 'package:chat_app_dart/contact_list/widget/contact_list_widget.dart';
import 'package:chat_app_dart/ripple_button/fancy_ripple_button.dart';
import 'package:chat_app_dart/chat_list/service/chat_list_service.dart';
import 'package:chat_app_dart/chat/user/service/user_service.dart';
import 'package:chat_app_dart/side_menu/controller/side_menu_controller.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/ripple_button/expanded_ripple.dart';

typedef TChatList = List<ChatModel>;

class ChatList extends StatefulWidget {
  ChatList(this.state, {super.key});
  final SideMenuState state;

  @override
  createState() => ChatListState();
}

class ChatListState extends State<ChatList> {
  final TChatList chatList = [];
  final SideMenuController sideMenuController = getIt<SideMenuController>();
  SideMenuState get state => widget.state;
  ChatListService chatListService = getIt<ChatListService>();

  @override
  void initState() {
    super.initState();
    chatListService.addListener(
      () {
        setState(() {
          chatList.clear();
          chatList.addAll(chatListService.chatList);
        });
      },
    );
    sideMenuController.addListener(
      () async {
        if (sideMenuController.value == SideMenuState.halfScreen) {
          await chatListService.getChats();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return state == SideMenuState.halfScreen || state == SideMenuState.noScreen
        ? AnimatedOpacity(
            duration: Duration(
                milliseconds: state == SideMenuState.noScreen ? 755 : 255),
            opacity: state == SideMenuState.halfScreen ? 1.0 : 0.0,
            child: AnimatedContainer(
                duration: sideMenuController.duration,
                transform: Matrix4.translationValues(
                    state == SideMenuState.halfScreen ? 0 : -255, 0, 0),
                padding: const EdgeInsets.all(15),
                child: FutureBuilder(
                  future: chatListService.getChats(),
                  builder: (context, snapshot) {
                    return Column(children: [
                      Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FancyRippleButton(
                                onTap: () {
                                  if (state == SideMenuState.fullScreen) {
                                    sideMenuController.halfScreen();
                                    return;
                                  }
                                  sideMenuController.fullScreen();
                                },
                                child: state == SideMenuState.fullScreen
                                    ? const Icon(Icons.close_fullscreen_rounded)
                                    : const Icon(Icons.add),
                              )
                            ],
                          )),
                      chatList.isEmpty
                          ? Expanded(
                              child: Container(
                                  child: const Center(
                                      child: Text("No Chats yet"))))
                          : Column(
                              children: chatList
                                  .map(
                                    (e) => Column(children: [
                                      FutureBuilder(
                                          future: getIt<UserService>()
                                              .findUserById(e.participants
                                                  .extractContactId()),
                                          builder: (context, snapshot) =>
                                              snapshot
                                                          .data?.id ==
                                                      getIt<ChatService>()
                                                          .chosenContactId
                                                  ? Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.7,
                                                      child: FancyRippleButton(
                                                        onTap: () =>
                                                            getIt<ChatService>()
                                                                .changeContact(
                                                                    snapshot
                                                                        .data!),
                                                        child: Text(
                                                          snapshot.data
                                                                  ?.username ??
                                                              "no user found for id ${e.participants.extractContactId()}",
                                                        ),
                                                      ))
                                                  : ExpandedRipple(
                                                      onTap: () =>
                                                          getIt<ChatService>()
                                                              .changeContact(
                                                                  snapshot
                                                                      .data!),
                                                      child: Text(
                                                        snapshot.data
                                                                ?.username ??
                                                            "no user found for id ${e.participants.extractContactId()}",
                                                      ),
                                                    )),
                                      const Divider(
                                        height: 35,
                                        endIndent: 25,
                                        indent: 25,
                                        color: Color.fromARGB(0, 0, 0, 0),
                                      )
                                    ]),
                                  )
                                  .toList())
                    ]);
                  },
                )))
        : ContactList();
  }
}

extension ContactExtractor on List<int> {
  extractContactId() => where(
        (element) => element != getIt<UserService>().activeUser?.id,
      ).first;
}
