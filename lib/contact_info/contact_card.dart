import 'package:chat_app_dart/chat/service/chat_service.dart';
import 'package:chat_app_dart/chat/user/model/user_model.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/online_dot/online_dot.dart';
import 'package:chat_app_dart/ripple_button/expanded_ripple.dart';
import 'package:chat_app_dart/ripple_button/fancy_ripple_button.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(this.user, {super.key});
  final User user;
  int? get chosenContactId => getIt<ChatService>().chosenContactId;
  @override
  Widget build(BuildContext context) {
    return user.id == chosenContactId
        ? Container(
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: FancyRippleButton(
              onTap: () => getIt<ChatService>().changeContact(user),
              child: Row(children: [
                Expanded(
                    child: Text(
                  user.username,
                )),
                OnlineDotWidget(contact: user.id)
              ]),
            ))
        : ExpandedRipple(
            onTap: () => getIt<ChatService>().changeContact(user),
            child: Row(children: [
              Expanded(
                  child: Text(
                user.username,
              )),
              OnlineDotWidget(contact: user.id)
            ]));
  }
}
