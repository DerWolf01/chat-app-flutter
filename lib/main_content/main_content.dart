import 'package:chat_app_dart/side_menu/controller/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/chat/widget/chat.dart';

class MainContent extends ContentBase {
  MainContent({super.key}) : super(builder: (_, state) => Chat(state));
}
