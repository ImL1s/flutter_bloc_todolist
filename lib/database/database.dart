import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../constant.dart';

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider();
  Database _database;


  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ReactiveTodo.db");

    var databasee = await openDatabase(path,
        version: 1, onCreate: initDb, onUpgrade: onUpgrade);

    return databasee;
  }

  FutureOr<void> initDb(Database db, int version) async {
    await db.execute("CREATE TABLE $TODO_TABLE ("
        "id INTEGER PRIMARY KEY, "
        "description TEXT, "
        "is_done INTEGER "
        ")");
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    if(newVersion > oldVersion){
      // todo
    }
  }
}
