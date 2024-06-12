import 'package:chat_app_dart/database/database.dart';
import 'package:chat_app_dart/firestore/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class UserService {
  UserService._internal();
  static UserService? _instance;
  factory UserService() {
    _instance ??= UserService._internal();
    return _instance!;
  }
  User? activeUser;
  ValueNotifier<bool> signedUp = ValueNotifier(false);
  Future<Database> get _db => DatabaseConnector().db;
  Future<User?> verifySignUp() async {
    try {
      var db = (await _db);
      var userMap = (await db.rawQuery("SELECT * FROM User")).firstOrNull;
      print("found user --> $userMap");
      if (userMap is Map<String, Object?>) {
        User user = User.fromMap(userMap);
        if (await signUpInFirestore(user.id)) {
          signedUp.value = true;
          activeUser = user;
          return user;
        }
      }
      signedUp.value = false;
      return null;
    } catch (e) {
      print(e);
      signedUp.value = false;
      return null;
    }
  }

  Future<int> signUp(User user) async {
    int res = -1;
    try {
      var db = (await _db);
      await db.execute("DROP TABLE IF EXISTS USER");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY, mobileNumber VARCHAR)");
      res = await db.insert(
          "User", {"id": user.id, "mobileNumber": "'${user.mobileNumber}'"},
          conflictAlgorithm: ConflictAlgorithm.replace);
      activeUser = user;
    } catch (e) {
      print(e);
    }
    print("logged in --> $res");
    if (res > -1) {
      signedUp.value = true;
    }
    return res;
  }

  Future signOut() async {
    activeUser = null;
    signedUp.value = false;
    (await _db).delete("User", where: "id = ?", whereArgs: [1]);
  }

  Future<bool> signUpInFirestore(int userId) async =>
      (await FirebaseFirestore.instance
              .collection("/user")
              .where("id", isEqualTo: userId)
              .get())
          .docs
          .firstOrNull
          ?.exists ==
      true;
}
