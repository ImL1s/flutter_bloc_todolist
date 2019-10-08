import 'package:flutter_bloc_learn/database/database.dart';
import 'package:flutter_bloc_learn/model/to_do.dart';

import '../constant.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.databaseProvider;

  Future<int> createTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = db.insert(TODO_TABLE, todo.toDatabaseJson());
    return result;
  }

  Future<List<Todo>> getTodos({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db.query(TODO_TABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["$query"]);
      }
    } else {
      result = await db.query(TODO_TABLE, columns: columns);
    }

    return result != null
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;
    return await db.update(TODO_TABLE, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.database;
    return await db.delete(TODO_TABLE, where: 'id = /', whereArgs: [id]);
  }

  Future<int> deleteAllTodos() async {
    final db = await dbProvider.database;
    return await db.delete(TODO_TABLE);
  }
}
