import 'package:chat_app_dart/side_menu/controller/side_menu_controller.dart';
import 'package:chat_app_dart/chat/widget/chat_list.dart';

class SideMenu extends SideMenuBase {
  SideMenu({super.key}) : super(builder: (_, state) => ChatList(state));
}
