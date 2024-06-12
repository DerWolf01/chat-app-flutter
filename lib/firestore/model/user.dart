import 'package:chat_app_dart/firestore/model/model.dart';

class User extends Model {
  const User(this.id, this.username);
  final int id;
  final String username;

  User.newUser(this.username) : id = DateTime.now().millisecondsSinceEpoch;

  User.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        username = map["username"];

  @override
  Map<String, dynamic> toMap() {
    return {"id": id, "username": username};
  }
}
