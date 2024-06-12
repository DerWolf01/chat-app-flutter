import 'package:chat_app_dart/firestore/model/model.dart';

class ChatModel extends Model {
  ChatModel(this.id, this.participants);
  final int id;
  final List<String> participants;

  ChatModel.fromMap(Map map)
      : id = map["id"],
        participants = map["participants"];
  @override
  Map<String, dynamic> toMap() {
    return {"id": id, "participants": participants};
  }
}
