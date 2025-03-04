import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/todo_model.dart';
import '../../cubit/todo_cubit.dart';
import 'add_todo_sheet.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: ListTile(
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) {
                      context.read<TodoCubit>().toggleTodo(todo);
                    },
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(todo.time, style: TextStyle(color: Colors.grey)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<TodoCubit>().deleteTodo(todo.id!);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => AddTodoSheet(),
          );
        },
      ),
    );
  }
}
