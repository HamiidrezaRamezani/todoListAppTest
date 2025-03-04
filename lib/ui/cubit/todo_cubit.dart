import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../data/models/todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepository repository;

  TodoCubit(this.repository) : super([]);

  Future<void> loadTodos() async {
    final todos = await repository.getTodos();
    emit(todos);
  }

  Future<void> addTodo(Todo todo) async {
    await repository.addTodo(todo);
    loadTodos();
  }

  Future<void> toggleTodo(Todo todo) async {
    final updatedTodo = Todo(
      id: todo.id,
      title: todo.title,
      time: todo.time,
      isToday: todo.isToday,
      isCompleted: !todo.isCompleted,
    );
    await repository.updateTodo(updatedTodo);
    loadTodos();
  }

  Future<void> deleteTodo(int id) async {
    await repository.deleteTodo(id);
    loadTodos();
  }
}
