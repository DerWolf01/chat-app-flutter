import 'package:chat_app_dart/firestore/model/model.dart';

class User extends Model {
  const User(this.id, this.mobileNumber);
  final int id;

  final String mobileNumber;

  User.newUser(this.mobileNumber) : id = DateTime.now().millisecondsSinceEpoch;

  User.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        mobileNumber = map["mobileNumber"];

  @override
  Map<String, dynamic> toMap() {
    return {"id": id, "mobileNumber": mobileNumber};
  }
}
