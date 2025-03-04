import '../../data/database/database_helper.dart';
import '../../data/models/todo_model.dart';

class TodoRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<List<Todo>> getTodos() async {
    return await dbHelper.getTodos();
  }

  Future<void> addTodo(Todo todo) async {
    await dbHelper.insertTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await dbHelper.updateTodo(todo);
  }

  Future<void> deleteTodo(int id) async {
    await dbHelper.deleteTodo(id);
  }
}
