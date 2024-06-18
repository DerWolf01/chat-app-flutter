import 'package:chat_app_dart/firestore/model/model.dart';

class Message extends Model {
  Message(this.sender, this.receiver, this.content)
      : id = DateTime.now().millisecondsSinceEpoch;
  final int id;
  final int sender;
  final int receiver;
  final String content;

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "receiver": receiver,
      "sender": sender,
      "content": content,
    };
  }

  Message.fromMap(Map map)
      : id = map["id"],
        receiver = int.parse(map["receiver"].toString()),
        sender = int.parse(map["sender"].toString()),
        content = map["content"];
}
