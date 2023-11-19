import 'package:flutter/material.dart';
import 'package:chat_app_dart/utils/user_session.dart';
import 'package:chat_app_dart/views/sign_up_view.dart';
import 'package:chat_app_dart/components/main_content/main_content.dart';
import 'package:chat_app_dart/components/sidebar/sidebar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    var session = UserSession.create();
    return ValueListenableBuilder(
      valueListenable: session.token,
      builder: (context, value, child) {
        if (value.isEmpty) {
          return const SignUpView();
        }

        return 
        
        Expanded(
            child: AnimatedContainer(
          duration: const Duration(milliseconds: 251),
          child: const Row(children: [
            Sidebar(),
            Divider(
              indent: 25.0,
              color: Colors.transparent,
            ),
            MainContent()
          ]),
        ));
      },
    );
  }
}
