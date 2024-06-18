import 'package:chat_app_dart/firestore/model/model.dart';

class ChatModel extends Model {
  ChatModel.newChat({required this.participants})
      : id = DateTime.now().millisecondsSinceEpoch;
  ChatModel(this.id, this.participants);
  final int id;
  final List<int> participants;

  ChatModel.fromMap(Map map)
      : id = map["id"],
        participants = (map["participants"] as List<dynamic>).toIntegerList();
  @override
  Map<String, dynamic> toMap() {
    return {"id": id, "participants": participants};
  }
}

extension on List {
  List<int> toIntegerList() =>
      map<int>((e) => int.parse(e.toString())).toList();
}
