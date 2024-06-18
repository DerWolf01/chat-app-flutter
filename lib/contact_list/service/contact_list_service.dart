import 'package:chat_app_dart/chat/user/service/user_service.dart';
import 'package:chat_app_dart/chat/user/model/user_model.dart';
import 'package:chat_app_dart/firestore/firestore.dart';
import 'package:chat_app_dart/get_it/setup.dart';

class ContactListService {
  Future<List<User>> getPotentialContacts() async {
    var contacts = (await collection("/user").where("id").get())
        .docs
        .map(
          (e) {
            var user = User.fromMap(e.data());
            return user;
          },
        )
        .where(
          (element) => element.id != getIt<UserService>().activeUser?.id,
        )
        .toList();

    return contacts;
  }
}
