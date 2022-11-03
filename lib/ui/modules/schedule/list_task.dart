import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/controllers/task_controller.dart';
import '../../../state/models/task_model.dart';
import '../../shared/custom_dialog.dart';
import '../../shared/empty_box.dart';
import '../task/edit_task_screen.dart';
import '../task/task_item.dart';

class ListTask extends StatefulWidget {
  const ListTask({super.key});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  int _selectedTask = -1;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Consumer<TaskController>(
      builder: (context, taskController, child) {
        final listTask = taskController.allItems;
        for (var item in listTask) {
          print(item.toString());
        }
        return listTask.isNotEmpty
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
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).backgroundColor,
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
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
            : const EmptyBox(message: 'Chưa có nhiệm vụ nào được tạo');
      },
    );
  }

  Row buildTaskControlButton(
      BuildContext context, List<TaskModel> listTask, int index) {
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
                  '*không thể phục hồi công việc đã xoá',
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
              onPressed: () {
                if (_selectedTask == 0) return;
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
              onPressed: () {
                if (_selectedTask == listTask.length - 1) return;
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
