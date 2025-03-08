import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupernino_bottom_sheet/flutter_cupernino_bottom_sheet.dart';
import 'package:todolistapp/ui/cubit/todo_cubit.dart';
import 'package:todolistapp/ui/view/screens/add_todo_sheet.dart';
import 'package:todolistapp/ui/view/system_design/app_colors.dart';
import 'package:todolistapp/ui/view/system_design/app_images.dart';
import 'package:todolistapp/ui/view/system_design/app_typography.dart';

import '../../../data/models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Container(
          height: 42.0,
          width: 42.0,
          margin: EdgeInsets.only(right: 14.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(126.0),
            child: Image.asset(
              AppImages.profile,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ]),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          final List<Todo> todayList =
              todos.where((todo) => todo.isToday).toList();
          final List<Todo> tomorrowList =
              todos.where((todo) => !todo.isToday).toList();
          return Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today",
                        style: AppTypography.boldTextView(
                            35, AppColors.blackColor),
                      ),
                      Text(
                        "Hide completed",
                        style: AppTypography.mediumTextView(
                            13.0, AppColors.blueColor, false),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  Expanded(
                    child: ListView(
                      children: [
                        ListView.builder(
                          itemCount: todayList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final todo = todayList[index];
                            return InkWell(
                              onTap: () {
                                context.read<TodoCubit>().toggleTodo(todo);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, bottom: 4.0),
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.4,
                                      child: Checkbox(
                                        value: todo.isCompleted,
                                        onChanged: (_) {
                                          context
                                              .read<TodoCubit>()
                                              .toggleTodo(todo);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        fillColor: MaterialStateProperty.all(
                                            todo.isCompleted
                                                ? AppColors.blackColor
                                                : AppColors.whiteColor),
                                        checkColor: AppColors.whiteColor,
                                        side: todo.isCompleted
                                            ? BorderSide.none
                                            : BorderSide(
                                                color: AppColors.borderWhite,
                                                width: 2.0),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            todo.title,
                                            style: AppTypography.mediumTextView(
                                                20,
                                                AppColors.textPrimaryColor,
                                                todo.isCompleted),
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            todo.time,
                                            style: AppTypography.mediumTextView(
                                                14,
                                                AppColors.textSecondaryColor,
                                                todo.isCompleted),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30.0),
                        Row(
                          children: [
                            Text(
                              "Tomorrow",
                              style: AppTypography.boldTextView(
                                  35, AppColors.blackColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        ListView.builder(
                          itemCount: tomorrowList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final todo = tomorrowList[index];
                            return ListTile(
                              leading: Container(
                                height: 10.0,
                                width: 10.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blackColor),
                              ),
                              title: Text(
                                todo.title,
                                style: AppTypography.mediumTextView(
                                    20, AppColors.textPrimaryColor, false),
                              ),
                              subtitle: Text(
                                todo.time,
                                style: AppTypography.mediumTextView(
                                    14, AppColors.textSecondaryColor, false),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
      floatingActionButton: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
            color: AppColors.blackColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.14),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                  spreadRadius: 0)
            ]),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              CupertinoBottomSheetRoute(
                args: const CupertinoBottomSheetRouteArgs(
                  swipeSettings: SwipeSettings(
                    canCloseBySwipe: true,
                  ),
                ),
                builder: (context) {
                  return AddTodoSheet();
                },
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(
            Icons.add,
            color: AppColors.whiteColor,
            size: 35,
          ),
        ),
      ),
    );
  }
}
