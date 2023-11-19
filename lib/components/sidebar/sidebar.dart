import 'package:flutter/material.dart';
import 'package:chat_app_dart/components/chat/chat_list.dart';
import 'package:chat_app_dart/utils/decorations.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {


    
    return AnimatedContainer(
        duration: const Duration(milliseconds: 1333),
        decoration: ShadowDecoration(),
        width: MediaQuery.of(context).size.width * 0.25,
        child: const ChatList());
  }
}
