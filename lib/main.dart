import 'package:chat_app_dart/firestore/firebase_options.dart';
import 'package:chat_app_dart/get_it/setup.dart';
import 'package:chat_app_dart/socket/socket_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_dart/main_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  setupGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  var app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instanceFor(
    app: app,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  runApp(const MainApp());
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: MaterialApp(home: Scaffold(body: MainView())));
  }
}
