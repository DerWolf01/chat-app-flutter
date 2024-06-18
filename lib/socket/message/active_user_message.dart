import 'package:chat_app_dart/socket/message/register_message.dart';

class ActiveUserMessage extends RegisterMessage {
  ActiveUserMessage(super.userId);
  ActiveUserMessage.fromMap(super.map) : super.fromMap();
}
