import 'package:advanced_change_notifier/advanced_change_notifier.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/socket/message/active_user_message.dart';
import 'package:chat_app_dart/socket/socket_service.dart';

class ActiveContactsService extends AdvancedChangeNotifier<int> {
  SocketService get socketService => getIt<SocketService>();

  Map<int, bool> active = {};
  ActiveContactsService() {
    socketService.addListener(
      (value) async {
        var content = value?.content;
        if (content is ActiveUserMessage) {
          print("got new user online!");
          active[content.userId] = true;
          notifyListeners(value: content.userId);
        }
      },
    );
  }
}
