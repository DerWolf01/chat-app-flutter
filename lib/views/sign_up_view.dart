import 'package:flutter/material.dart';
import 'package:chat_app_dart/components/form_components/form.dart';
import 'package:chat_app_dart/tcp_sockets/client/client.dart';
import 'package:chat_app_dart/tcp_sockets/message/sign_up.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return MessageForm<SignUp>(
      onSubmit: (SignUp instance) async {
        TCPClient client = await TCPClient.connect();
        client.write(instance);
      },
    );
  }
}
