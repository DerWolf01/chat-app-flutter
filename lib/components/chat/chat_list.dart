import 'package:flutter/material.dart';
import 'package:chat_app_dart/components/ripple_button/expanded_ripple.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      ExpandedRipple(child: Center(child: Text("contact"))),
      ExpandedRipple(child: Center(child: Text("contact"))),
      ExpandedRipple(child: Center(child: Text("contact"))),
      ExpandedRipple(child: Center(child: Text("contact"))),
      ExpandedRipple(child: Center(child: Text("contact"))),
    ]);
  }
}
