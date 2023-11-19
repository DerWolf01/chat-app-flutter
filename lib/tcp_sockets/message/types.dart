import 'package:chat_app_dart/tcp_sockets/message/response/server_response.dart';
import 'package:chat_app_dart/tcp_sockets/message/response/sign_up_response.dart';
import 'package:chat_app_dart/tcp_sockets/message/sign_up.dart';

Map<String, dynamic> types = {
  "SignUp": SignUp,
  "ServerResponse": ServerResponse,
  "SignUpResponse": SignUpResponse
};
