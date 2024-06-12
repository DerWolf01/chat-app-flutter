import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseConnector {
  DatabaseConnector._internal();
  Database? database;
  static DatabaseConnector? _instance;

  factory DatabaseConnector() {
    _instance ??= DatabaseConnector._internal();
    return _instance!;
  }

  Future<Database> get db async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'chat_app.db');
    database ??= await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        try {
          await db.execute(
              "CREATE TABLE  User (id INTEGER PRIMARY KEY, mobileNumber VARCHAR)");
        } catch (e) {
          print(e);
        }
      },
      onOpen: (db) async {
        try {
          await db.execute(
              "CREATE TABLE  User (id INTEGER PRIMARY KEY, mobileNumber VARCHAR)");
        } catch (e) {
          print(e);
        }
      },
    );
    return database!;
  }
}
