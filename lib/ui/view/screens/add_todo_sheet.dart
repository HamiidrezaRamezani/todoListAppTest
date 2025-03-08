import 'package:animated_slide_switcher/animated_slide_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistapp/ui/view/system_design/app_colors.dart';
import 'package:todolistapp/ui/view/system_design/app_typography.dart';

import '../../../data/models/todo_model.dart';
import '../../cubit/todo_cubit.dart';

class AddTodoSheet extends StatefulWidget {
  @override
  _AddTodoSheetState createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  final TextEditingController _titleController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

  // String _selectedTime = "انتخاب ساعت";
  String timeZone = "AM";
  bool _isToday = false;

  // Future<void> _pickTime() async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //   if (pickedTime != null) {
  //     setState(() {
  //       _selectedTime = pickedTime.format(context);
  //     });
  //   }
  // }

  void _addTask() {
    if (_titleController.text.isEmpty) return;

    final newTodo = Todo(
      title: _titleController.text,
      time: "${selectedTime.hour}:${selectedTime.minute} $timeZone",
      isToday: _isToday,
    );

    context.read<TodoCubit>().addTodo(newTodo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 16.0,
        ),
        SizedBox(
          height: 56.0,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Task',
                  style: AppTypography.boldTextView(18, AppColors.blackColor),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 42.0,
                      width: 78,
                      margin: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.blueColor,
                          ),
                          Text(
                            "Close",
                            style: AppTypography.regularTextView(
                                18.0, AppColors.blueColor),
                          )
                        ],
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Divider(
                  height: 1.0,
                  color: AppColors.textPrimaryColor.withOpacity(0.5),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 37.0,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 34.0, right: 34.0),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Text(
                    "Add a task",
                    style:
                        AppTypography.boldTextView(34.0, AppColors.blackColor),
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Text(
                    "Name",
                    style:
                        AppTypography.boldTextView(20.0, AppColors.blackColor),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Enter Name ...',
                        hintStyle: AppTypography.regularTextView(
                            15.0, AppColors.textSecondaryColor),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textSecondaryColor
                                  .withOpacity(0.5)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.textSecondaryColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              // GestureDetector(
              //   onTap: _pickTime,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(_selectedTime, style: TextStyle(fontSize: 16)),
              //       Icon(Icons.access_time, color: Colors.blue),
              //     ],
              //   ),
              // ),
              Row(
                children: [
                  Text(
                    "Hour",
                    style:
                        AppTypography.boldTextView(20.0, AppColors.blackColor),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 110.0,
                            height: 42.0,
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 42.0,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.time,
                                    initialDateTime: DateTime(2022, 1, 1,
                                        selectedTime.hour, selectedTime.minute),
                                    use24hFormat: true,
                                    onDateTimeChanged: (DateTime newTime) {
                                      setState(() {
                                        selectedTime = TimeOfDay(
                                            hour: newTime.hour,
                                            minute: newTime.minute);
                                      });
                                      if (newTime.hour > 12) {
                                        setState(() {
                                          timeZone = "PM";
                                        });
                                      } else if (newTime.hour < 12) {
                                        setState(() {
                                          timeZone = "AM";
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 38.0,
                        width: 62.0,
                        decoration: BoxDecoration(
                            color: Color(0xFF767680).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(9.0)),
                        child: Center(
                          child: Container(
                            height: 30.0,
                            width: 54.0,
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(9.0)),
                            child: Center(
                              child: AnimatedSlideSwitcher<String>(
                                value: timeZone,
                                builder: (context, value) => Text(
                                  value,
                                  style: AppTypography.boldTextView(
                                      16.0, AppColors.blackColor),
                                ),
                                direction: AnimationDirection.upToDown,
                                incomingDuration: Duration(milliseconds: 500),
                                outgoingDuration: Duration(milliseconds: 150),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Today",
                      style: AppTypography.boldTextView(
                          20.0, AppColors.blackColor)),
                  // Switch(
                  //   value: _isToday,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _isToday = value;
                  //     });
                  //   },
                  // ),
                  CupertinoSwitch(
                    activeColor: AppColors.greenColor,
                    value: _isToday,
                    onChanged: (v) => setState(() => _isToday = v),
                  ),
                ],
              ),
              SizedBox(height: 62),
              ElevatedButton(
                onPressed: _addTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.btnColor,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Done',
                  style: AppTypography.mediumTextView(
                      15.0, AppColors.whiteColor, false),
                ),
              ),
              SizedBox(height: 14),
              Text(
                'If you disable today, the task will be considered as tomorrow',
                style: AppTypography.regularTextView(
                    14.0, AppColors.textSecondaryColor),
              )
            ],
          ),
        ))
      ],
    );
  }
}
