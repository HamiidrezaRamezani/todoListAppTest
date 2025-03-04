import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/todo_model.dart';
import '../../cubit/todo_cubit.dart';

class AddTodoSheet extends StatefulWidget {
  @override
  _AddTodoSheetState createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  final TextEditingController _titleController = TextEditingController();
  String _selectedTime = "انتخاب ساعت";
  bool _isToday = false;

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime.format(context);
      });
    }
  }

  void _addTask() {
    if (_titleController.text.isEmpty || _selectedTime == "انتخاب ساعت") return;

    final newTodo = Todo(
      title: _titleController.text,
      time: _selectedTime,
      isToday: _isToday,
    );

    context.read<TodoCubit>().addTodo(newTodo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'عنوان تسک'),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: _pickTime,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedTime, style: TextStyle(fontSize: 16)),
                Icon(Icons.access_time, color: Colors.blue),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("امروز؟", style: TextStyle(fontSize: 16)),
              Switch(
                value: _isToday,
                onChanged: (value) {
                  setState(() {
                    _isToday = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addTask,
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}
