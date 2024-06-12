import 'package:chat_app_dart/components/form_components/input_field.dart';
import 'package:chat_app_dart/components/ripple_button/fancy_ripple_button.dart';
import 'package:chat_app_dart/components/service/user_service.dart';
import 'package:chat_app_dart/firestore/firestore.dart';
import 'package:chat_app_dart/firestore/model/user.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/components/main_content/main_content.dart';
import 'package:chat_app_dart/components/sidebar/sidebar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    
     FutureBuilder(
        future: UserService().verifySignUp(),
        builder: (context, snapshot) {
          return ValueListenableBuilder(
              valueListenable: UserService().signedUp,
              builder: (context, signedUp, child) {
                if (!signedUp) {
                  return const SignUpWidget();
                }
                return Stack(children: [
                  const MainContent(),
                  SideMenu(),
                ]);
              });
        });
  }
}

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  Future signUp(User user) async {
    var res = await collection("user").add(user.toMap());
    var verifySignUp = await UserService().signUp(user);

    return;
  }

  @override
  Widget build(BuildContext context) {
    String mobileNumber = "";
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
              onChanged: (texvalue) {
                mobileNumber = texvalue;
                print("mobile-number --> $mobileNumber");
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
                      await signUp(User.newUser(mobileNumber));
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
