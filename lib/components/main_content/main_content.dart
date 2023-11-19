import 'package:flutter/material.dart';
import 'package:chat_app_dart/components/chat/chat.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.75 - 25.0,
        child: const Center(child: Chat()));
  }
}
