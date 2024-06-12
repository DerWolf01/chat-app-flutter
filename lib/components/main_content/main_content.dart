import 'package:chat_app_dart/controller/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/components/chat/widget/chat.dart';

class MainContent extends ContentBase {
  MainContent({super.key})
      : super(builder: (_, state) => Center(child: Chat(state)));
}
