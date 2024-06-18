import 'package:chat_app_dart/chat/service/chat_service.dart';
import 'package:chat_app_dart/chat_list/service/chat_list_service.dart';
import 'package:chat_app_dart/contact_list/service/contact_list_service.dart';
import 'package:chat_app_dart/chat/user/service/user_service.dart';
import 'package:chat_app_dart/side_menu/controller/side_menu_controller.dart';
import 'package:chat_app_dart/database/database.dart';
import 'package:chat_app_dart/socket/socket_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupGetIt() {
  getIt.registerSingleton<SideMenuController>(SideMenuController());
  getIt.registerSingleton<DatabaseConnector>(DatabaseConnector());
  getIt.registerSingleton<UserService>(UserService());
  getIt.registerSingleton<ContactListService>(ContactListService());
  getIt.registerSingleton<ChatService>(ChatService());
  getIt.registerSingleton<ChatListService>(ChatListService());
  getIt.registerSingleton<SocketService>(SocketService());
}
