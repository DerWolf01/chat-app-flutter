import 'package:chat_app_dart/chat/service/chat_service.dart';
import 'package:chat_app_dart/contact_list/service/contact_list_service.dart';
import 'package:chat_app_dart/ripple_button/fancy_ripple_button.dart';
import 'package:chat_app_dart/scroller/scroller.dart';
import 'package:chat_app_dart/side_menu/controller/side_menu_controller.dart';
import 'package:chat_app_dart/chat/user/model/user_model.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  ContactList({super.key});

  final SideMenuController sideMenuController = getIt<SideMenuController>();
  Duration get duration => sideMenuController.duration;
  Curve get curve => sideMenuController.curve;
  final ValueNotifier<bool> animate = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => animate.value = true,
    );
    return ValueListenableBuilder(
        valueListenable: animate,
        builder: (context, animate, child) => AnimatedOpacity(
            curve: curve,
            duration: duration,
            opacity: animate ? 1.0 : 0.0,
            child: AnimatedContainer(
                transform: Matrix4.translationValues(animate ? 0 : -255, 0, 0),
                duration:
                    !animate ? duration : const Duration(milliseconds: 755),
                curve: curve,
                padding: const EdgeInsets.all(25),
                child: FutureBuilder(
                    future: getIt<ContactListService>().getPotentialContacts(),
                    builder: (context, snapshot) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Make a new friend",
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w500),
                              ),
                              const Divider(
                                color: Colors.transparent,
                                height: 25,
                              ),
                              Expanded(
                                  child: Scroller(Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: snapshot.data != null
                                    ? (snapshot.data!
                                        .map((e) => contact(e))
                                        .toList())
                                    : const [Text("No users registered")],
                              )))
                            ])))));
  }

  Widget contact(User user) => Column(children: [
        // user.id == getIt<ChatService>().chosenContactId
        //     ?
        FancyRippleButton(
          onTap: () {
            animate.value = false;
            Future.delayed(
              const Duration(milliseconds: 355),
              () => getIt<ChatService>().changeContact(user),
            );
          },
          child: Center(child: Text(user.username)),
        )
        // : ExpandedRipple(
        //     onTap: () {
        //       animate.value = false;
        //       Future.delayed(
        //         const Duration(milliseconds: 355),
        //         () {
        //           sideMenuController.noScreen();
        //           getIt<ChatService>().changeContact(user);
        //         },
        //       );
        //     },
        //     decoration: BoxDecoration(
        //         color: const Color.fromARGB(73, 158, 158, 158),
        //         borderRadius: BorderRadius.circular(19)),
        //     child: Center(child: Text(user.username)),
        //   )
        ,
        Divider(
          height: 35,
          endIndent: 25,
          indent: 25,
          color: const Color.fromARGB(41, 0, 0, 0),
        )
      ]);
}
