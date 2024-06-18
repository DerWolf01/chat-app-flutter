import 'package:chat_app_dart/chat/message/message_model.dart';
import 'package:chat_app_dart/chat/model/chat_model.dart';
import 'package:chat_app_dart/chat/user/service/user_service.dart';
import 'package:chat_app_dart/chat/user/model/user_model.dart';
import 'package:chat_app_dart/list_change_notifiers/list_change_notifier.dart';
import 'package:chat_app_dart/firestore/firestore.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/side_menu/controller/side_menu_controller.dart';
import 'package:chat_app_dart/socket/socket_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService extends ListChangeNotifier<Message> {
  User? chosenContact;
  int? get activeUserId => userService.activeUser?.id;
  int? get chosenContactId => chosenContact?.id;

  //services
  UserService userService = getIt<UserService>();
  SocketService get socketService => getIt<SocketService>();

  final List<Message> _lastMessages = [];
  changeContact(User user) async {
    getIt<SideMenuController>().noScreen();
    chosenContact = user;
    print(chosenContactId);
    _lastMessages.clear();
    notifyListChangeListeners(value: await getMessages());
    socketService.addListener(
      (value) async {
        var content = value?.content;
        if (content is Message) {
          if (content.receiver == activeUserId &&
              content.sender == chosenContactId) {
            notifyListeners(value: content);
          }
        }
      },
    );
  }

  Future<void> sendMessage(String text) async {
    print("sending message!");
    if (!usersExists) {
      return;
    }
    await createChatIfDoesntExist();

    var message = Message(userService.activeUser!.id, chosenContact!.id, text);
    var res = await collection("/messages").add(message.toMap());

    await notifyListeners(value: message);
    return;
  }

  Future<List<Message>> getMessages() async {
    if (!usersExists) {
      print(await userService.verifySignUp());
      print("users do not exists --> $activeUserId --> $chosenContactId");
      return [];
    }
    _lastMessages.clear();
    _lastMessages.addAll((await getDocs("/messages")).whereParticipants(
        [activeUserId!, chosenContactId!]).toSortedMessageList());
    return _lastMessages;
  }

  Future<ChatModel?> chatByParticipants(List<int> participants) async {
    var chat = (await getDocs("/chats"))
        .where(
          (element) {
            var model = ChatModel.fromMap(element.data());
            return model.participants.contains(participants[0]) &&
                model.participants.contains(participants[1]);
          },
        )
        .firstOrNull
        ?.data();

    if (chat != null) {
      return ChatModel.fromMap(chat);
    }
    return null;
  }

  Future createChatIfDoesntExist() async => (await chatExists())
      ? null
      : await collection("/chats").add(
          ChatModel.newChat(participants: [chosenContactId!, activeUserId!])
              .toMap(),
        );
  Future<bool> chatExists() async =>
      await chatExistenceByParticipants([chosenContactId!, activeUserId!]);

  Future<bool> chatExistenceByParticipants(List<int> participants) async =>
      await chatByParticipants(participants) != null;

  bool get usersExists => activeUserId != null && chosenContact != null;
}

extension MessageListExtension on List<Message> {
  List<Message> sortMessages() {
    for (int i = 0; i < length - 1; i++) {
      var next = this[i + 1];
      if (this[i].id > next.id) {
        this[i + 1] = this[i];
        this[i] = next;
      }
    }
    return this;
  }
}

extension FirebaseListDocsSortingExtension<T extends Map>
    on List<QueryDocumentSnapshot<T>> {
  List<QueryDocumentSnapshot<T>> whereParticipants(List<int> participants) {
    var user1 = participants[0];
    var user2 = participants[1];
    return where(
      (e) {
        if (e.data()["receiver"] == user1 && e.data()["sender"] == user2) {
          return true;
        } else if (e.data()["sender"] == user1 &&
            e.data()["receiver"] == user2) {
          return true;
        }

        return false;
      },
    ).toList();
  }

  List<Message> toMessageList() {
    return map(
      (e) => Message.fromMap(e.data()),
    ).toList();
  }

  List<Message> toSortedMessageList() => toMessageList().sortMessages();
}

extension on List {
  List<int> toIntegerList() =>
      map<int>((e) => int.parse(e.toString())).toList();
}
