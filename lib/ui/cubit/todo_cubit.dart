import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../data/models/todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepository repository;

  TodoCubit(this.repository) : super([]);

  // بارگذاری تسک‌ها از دیتابیس
  Future<void> loadTodos() async {
    final todos = await repository.getTodos();
    emit(todos);
  }

  // افزودن تسک جدید
  Future<void> addTodo(Todo todo) async {
    await repository.addTodo(todo);
    loadTodos(); // بارگذاری دوباره تسک‌ها بعد از اضافه شدن
  }

  // تغییر وضعیت تکمیل تسک
  Future<void> toggleTodo(Todo todo) async {
    final updatedTodo = Todo(
      id: todo.id,
      title: todo.title,
      time: todo.time,  // نگهداری ساعت
      isToday: todo.isToday,  // نگهداری وضعیت "امروز"
      isCompleted: !todo.isCompleted,  // تغییر وضعیت تکمیل
    );
    await repository.updateTodo(updatedTodo);
    loadTodos(); // بارگذاری دوباره تسک‌ها بعد از بروزرسانی
  }

  // حذف تسک
  Future<void> deleteTodo(int id) async {
    await repository.deleteTodo(id);
    loadTodos(); // بارگذاری دوباره تسک‌ها بعد از حذف
  }
}
