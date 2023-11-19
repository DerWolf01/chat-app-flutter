import 'package:chat_app_dart/tcp_sockets/message/sign_up.dart';

class SignUpService {
  dynamic handleSignUp(SignUp signUp) {
    print(signUp.password + " " + signUp.username);
  }
}
