import 'package:chat_app_dart/controller/side_menu_controller.dart';
import 'package:chat_app_dart/components/chat/widget/chat_list.dart';

class SideMenu extends SideMenuBase {
  SideMenu({super.key}) : super(builder: (_, state) => ChatList(state));
}
