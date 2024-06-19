import 'package:chat_app_dart/form_components/input_field.dart';
import 'package:chat_app_dart/ripple_button/fancy_ripple_button.dart';
import 'package:chat_app_dart/chat/user/service/user_service.dart';
import 'package:chat_app_dart/firestore/firestore.dart';
import 'package:chat_app_dart/chat/user/model/user_model.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/socket/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/main_content/main_content.dart';
import 'package:chat_app_dart/side_menu/side_menu_widget.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(),
        clipBehavior: Clip.antiAlias,
        child: FutureBuilder(
            future: getIt<UserService>().verifySignUp(),
            builder: (context, snapshot) {
              return ValueListenableBuilder(
                  valueListenable: getIt<UserService>().signedUp,
                  builder: (context, signedUp, child) {
                    print("signedUp --> $signedUp");
                    // if (signedUp == false) {
                    //   return const SignUpWidget();
                    // } else {
                    getIt<SocketService>().registerClient();

                    return Stack(children: [
                      MainContent(),
                      SideMenu(),
                    ]);
                    // }
                  });
            }));
  }
}

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  Future signUp(User user) async {
    var res = await collection("user").add(user.toMap());
    var verifySignUp = await getIt<UserService>().signUp(user);

    return;
  }

  @override
  Widget build(BuildContext context) {
    String username = "";
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Already registered?"),
            const Divider(
              color: Colors.transparent,
            ),
            InputField(
              onChanged: (textValue) {
                username = textValue;
              },
              lable: "mobile number",
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Container(
                width: MediaQuery.sizeOf(context).width,
                child: FancyRippleButton(
                    onTap: () async {
                      await signUp(User.newUser(username));
                    },
                    // ignore: prefer_const_constructors
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "register",
                          style: TextStyle(color: Colors.white),
                        ),
                        VerticalDivider(
                          color: Colors.transparent,
                        ),
                        Icon(
                          Icons.login_rounded,
                          color: Colors.white,
                        )
                      ],
                    )))
          ]),
    );
  }
}
