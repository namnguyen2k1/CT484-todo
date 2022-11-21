import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/controllers/task_controller.dart';
import '../../../state/models/task_model_change_notifier.dart';
import '../../shared/custom_dialog.dart';
import '../../shared/empty_box.dart';
import '../task/edit_task_screen.dart';
import '../task/task_item.dart';
import '../utilities/format_time.dart';

class ListTask extends StatefulWidget {
  const ListTask({super.key});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  int _selectedTask = -1;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  List<TaskModel> fillterTaskDaily(List<TaskModel> tasks) {
    final filterTasks = tasks
        .where((task) =>
            FormatTime.convertTimestampToFormatTimer(task.createdAt) ==
            FormatTime.convertTimestampToFormatTimer(_selectedDate.toString()))
        .toList();
    return filterTasks;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final taskController = Provider.of<TaskController>(context, listen: true);
    final listTask = fillterTaskDaily(taskController.allItems);

    return Column(
      children: [
        buildTaskHeader(context, listTask),
        Expanded(
          child: listTask.isNotEmpty
              ? ListView.builder(
                  itemCount: listTask.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bool isMatch = _selectedTask == index;
                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: deviceSize.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTask = index;
                                });
                              },
                              child: TaskItem(
                                item: listTask[index],
                              ),
                            ),
                          ),
                          isMatch
                              ? buildTaskControlButton(context, listTask, index)
                              : const SizedBox(
                                  width: 0,
                                ),
                        ],
                      ),
                    );
                  },
                )
              : const EmptyBox(message: 'Chưa có công việc nào được tạo'),
        ),
      ],
    );
  }

  Container buildTaskHeader(BuildContext context, List<TaskModel> listTasks) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 20, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.date_range_rounded,
                color: Theme.of(context).focusColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${FormatTime.formatTimeLocalArea(time: _selectedDate)}   -- ${listTasks.length} việc --',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.manage_search,
              color: Theme.of(context).focusColor,
            ),
            onPressed: () async {
              final currentDate = DateTime.now();
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: currentDate,
                firstDate: DateTime(currentDate.year - 1),
                lastDate: DateTime(currentDate.year + 1),
              );
              setState(() {
                _selectedDate = selectedDate!;
                _selectedTask = -1;
              });
            },
          ),
        ],
      ),
    );
  }

  Row buildTaskControlButton(
    BuildContext context,
    List<TaskModel> listTask,
    int index,
  ) {
    final taskController = context.read<TaskController>();
    const EdgeInsetsGeometry paddingButton = EdgeInsets.all(5.0);
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            IconButton(
              padding: paddingButton,
              constraints: const BoxConstraints(),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(listTask[index]),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
            IconButton(
              padding: paddingButton,
              constraints: const BoxConstraints(),
              onPressed: () async {
                final bool? isAccept = await CustomDialog.showConfirm(
                  context,
                  'Bạn muốn xoá công việc này?',
                  '*không thể phục hồi các công việc đã xoá',
                );
                if (isAccept != false) {
                  await taskController.deleteItemById(
                    listTask[index].id,
                  );
                }
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
            IconButton(
              padding: paddingButton,
              constraints: const BoxConstraints(),
              onPressed: () async {
                if (_selectedTask == 0) {
                  setState(() {
                    _selectedTask = -1;
                  });
                  return;
                }

                final indexItemOnListTask = taskController.allItems.indexWhere(
                  (item) => item.id == listTask[index].id,
                );
                await taskController.swapTwoItem(
                  indexItemOnListTask,
                  indexItemOnListTask - 1,
                );

                setState(() {
                  _selectedTask = _selectedTask - 1;
                });
              },
              icon: const Icon(
                Icons.arrow_circle_up,
              ),
            ),
            IconButton(
              padding: paddingButton,
              constraints: const BoxConstraints(),
              onPressed: () async {
                if (_selectedTask == listTask.length - 1) {
                  setState(() {
                    _selectedTask = -1;
                  });
                  return;
                }

                final indexItemOnListTask = taskController.allItems.indexWhere(
                  (item) => item.id == listTask[index].id,
                );
                await taskController.swapTwoItem(
                  indexItemOnListTask,
                  indexItemOnListTask + 1,
                );
                setState(() {
                  _selectedTask = _selectedTask + 1;
                });
              },
              icon: const Icon(
                Icons.arrow_circle_down,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
