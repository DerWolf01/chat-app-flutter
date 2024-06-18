import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference<Map<String, dynamic>> collection(String path) {
  return FirebaseFirestore.instance.collection(path);
}

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDocs(
        String path) async =>
    (await collection(path).get()).docs;

Future<List<DocumentChange<Map<String, dynamic>>>> getDocsChanges(
        String path) async =>
    (await collection(path).get()).docChanges;
