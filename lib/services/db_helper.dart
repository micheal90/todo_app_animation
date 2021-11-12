import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_animated_app/models/task_model.dart';

class DBHelper {
  static Database? db;
  static const String _tableName = 'tasks';

  static init() async {
    if (db != null) {
      debugPrint('db not null');
      return;
    }
    try {
      db = await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,note TEXT,date TEXT,startDate TEXT, endDate TEXT,reminder INTEGER, repeat TEXT, color INTEGER,isCompleted TEXT)');

          debugPrint('Database Created');
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    return await db!.rawQuery('SELECT * FROM $_tableName');
  }

  static Future<int> addTask(Task task) async {
    try {
      return await db!.insert(_tableName, task.toMap());
    } catch (e) {
      debugPrint('Error!, task not inserted\n$e');
      return 00000;
    }
  }

  static Future<int> changeStatus(int taskId, String isCompleted) async {
    try {
      return await db!.rawUpdate(
        'UPDATE $_tableName SET isCompleted="$isCompleted" WHERE id = $taskId',
      );
    } catch (e) {
      debugPrint('Error!, task not updated\n$e');
      return 00000;
    }
  }

  static Future<int> deleteTask(int taskId) async {
    try {
      return await db!
          .rawDelete('DELETE FROM $_tableName WHERE id = "$taskId"');
    } catch (e) {
      debugPrint('Error!,$e');
      return 00000;
    }
  }

  static Future<int> deleteTable() async {
        return await db!.delete(_tableName);
  }
}
