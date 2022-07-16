import 'package:chat_app/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();
  //DatabaseService._privateConstructor();

  static final DatabaseService dbInstance = DatabaseService._();
  static const dbVersion = 1;
  static const dbName = "vigoplace_chat.db";

  static const String MESSAGE_TABLE = "messages";
  static const String USER_TABLE = "users";

  static const String USER_ID = 'id';
  static const String USER_NAME = 'name';

  static const String COLUMN_MESSAGE_ID = "id";
  static const String COLUMN_USER_ID = "uuid";
  static const String COLUMN_TIMESTAMP = "time";
  static const String COLUMN_SENDER = "bassey";
  static const String COLUMN_MESSAGE = "message";
  static const String COLUMN_READ = "read";

  static Database? _database;

  Future<Database?> get database async {
    return _database;
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, dbName), version: dbVersion,
        onCreate: (Database database, int version) async {
      debugPrint("Creating New DB...");
      await database.execute(
        "CREATE TABLE $MESSAGE_TABLE ("
        "$COLUMN_MESSAGE_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
        "$COLUMN_USER_ID TEXT UNIQUE, "
        "$COLUMN_TIMESTAMP TEXT, "
        "$COLUMN_SENDER TEXT, "
        "$COLUMN_MESSAGE TEXT, "
        "$COLUMN_READ TEXT "
        ")",
      );

      await database.execute(
        "CREATE TABLE $USER_TABLE ("
        "$USER_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
        "$USER_NAME TEXT "
        ")",
      );
    });
  }

  Future<void> addUser(name) async {
    final db = await database;

    db?.rawInsert('INSERT INTO $USER_TABLE($USER_NAME) VALUES($name)');
    print("user inserted $name");
    //return await db.insert(USER_TABLE, name);
  }

  /*Future<void> addMessage(userID, message, time, sender, read) async{
    final db = await database;

    final res = db?.rawInsert('INSERT INTO $MESSAGE_TABLE($COLUMN_USER_ID, $COLUMN_TIMESTAMP, $COLUMN_SENDER, $COLUMN_MESSAGE, $COLUMN_READ) VALUES($userID, $time, $sender, $message, $read)');
    print(res);
  }*/


  Future<void> addMessage(Message message) async {
    final db = await database;
    final res = await db?.insert(
      MESSAGE_TABLE,
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(res);
  }

}


