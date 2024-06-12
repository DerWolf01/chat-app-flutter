import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference<Map<String, dynamic>> collection(String path) {
  return FirebaseFirestore.instance.collection(path);
}


enum Collections {
  chats,
  messages,
  users,
  
}