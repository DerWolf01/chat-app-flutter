import 'package:chat_app_dart/firestore/model/model.dart';

class SocketMessage<T extends Model> extends Model {
  SocketMessage(this.content);
  T content;
  @override
  Map<String, dynamic> toMap() {
    return {"type": content.runtimeType.toString(), ...content.toMap()};
  }
}
