import 'package:chat_app_dart/controller/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/components/chat/chat.dart';

class MainContent extends ContentBase {
  const MainContent({super.key}) : super(child: const Center(child: Chat()));
}
