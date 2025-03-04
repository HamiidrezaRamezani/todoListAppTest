import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'todos';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE todos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          time TEXT NOT NULL,
          isToday INTEGER NOT NULL,
          isCompleted INTEGER NOT NULL
        )
      ''');
      },
    );
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    return await db.insert(tableName, todo.toMap());
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps.map((map) => Todo.fromMap(map)).toList();
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      tableName,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
