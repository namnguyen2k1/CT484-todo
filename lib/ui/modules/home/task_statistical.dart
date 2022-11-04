import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/models/task_model.dart';
import 'package:todoapp/ui/shared/empty_box.dart';

import '../../../state/controllers/app_settings_controller.dart';
import '../../../state/controllers/task_controller.dart';
import '../utilities/format_time.dart';

class TaskStatistical extends StatefulWidget {
  const TaskStatistical({super.key});

  @override
  State<TaskStatistical> createState() => _TaskStatisticalState();
}

class _TaskStatisticalState extends State<TaskStatistical> {
  DateTime _selectedDate = DateTime.now();

  List<TaskModel> _fillterTaskDaily(List<TaskModel> tasks) {
    final filterTasks = tasks
        .where((element) =>
            FormatTime.convertTimestampToFormatTimer(element.createdAt) ==
            FormatTime.convertTimestampToFormatTimer(_selectedDate.toString()))
        .toList();
    return filterTasks;
  }

  @override
  Widget build(BuildContext context) {
    final allTasks = Provider.of<TaskController>(context).allItems;
    final tasks = _fillterTaskDaily(allTasks);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
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
                    FormatTime.formatTimeLocalArea(time: _selectedDate),
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
                  });
                },
              ),
            ],
          ),
        ),
        tasks.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, index) {
                          double percentCircle = 0.0;
                          int percentText = 0;
                          percentCircle = tasks
                                  .where(
                                      (element) => element.isCompleted == true)
                                  .toList()
                                  .length /
                              tasks.length;
                          percentText = (tasks
                                      .where((element) =>
                                          element.isCompleted == true)
                                      .toList()
                                      .length /
                                  tasks.length *
                                  100)
                              .floor();

                          return CircularPercentIndicator(
                            circularStrokeCap: CircularStrokeCap.round,
                            radius: 60.0,
                            lineWidth: 10.0,
                            percent: percentCircle,
                            center: Text(
                              "$percentText %",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).focusColor,
                                fontSize: 20.0,
                              ),
                            ),
                            backgroundColor: Colors.transparent,
                            progressColor: Colors.green,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTotalTaskType(
                            size: 30,
                            icon: Icons.list,
                            backgroundColor: Colors.purple,
                            label: "${tasks.length} việc",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildTotalTaskType(
                            size: 30,
                            icon: Icons.pending,
                            backgroundColor: Colors.red,
                            label:
                                "${tasks.where((element) => element.isCompleted == false).toList().length} việc",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildTotalTaskType(
                            size: 30,
                            icon: Icons.done,
                            backgroundColor: Colors.green,
                            label:
                                "${tasks.where((element) => element.isCompleted == true).toList().length} việc",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTotalTaskType(
                            size: 30,
                            icon: Icons.notification_important_outlined,
                            backgroundColor: Colors.blue,
                            label:
                                "${tasks.where((element) => element.star == 1).toList().length} việc",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildTotalTaskType(
                            size: 30,
                            icon: Icons.notification_important_outlined,
                            backgroundColor: Colors.deepPurpleAccent,
                            label:
                                "${tasks.where((element) => element.star == 2).toList().length} việc",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildTotalTaskType(
                            size: 30,
                            icon: Icons.notification_important,
                            backgroundColor: Colors.red,
                            label:
                                "${tasks.where((element) => element.star == 3).toList().length} việc",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const EmptyBox(message: 'Không tồn tại kế hoạch làm việc'),
        if (tasks.where((element) => element.isCompleted == true).length ==
                tasks.length &&
            FormatTime.convertTimestampToFormatTimer(
                    _selectedDate.toString()) ==
                FormatTime.convertTimestampToFormatTimer(
                    DateTime.now().toString())) ...[
          // kiểm tra: tất cả công việc đều hoàn thành và ngày lựa chọn phải là hôm nay
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: EmptyBox(
              message: 'Bạn đã hoàn thành tất cả công việc của ngày hôm nay',
            ),
          )
        ],
      ],
    );
  }

  Row buildTotalTaskType({
    required double size,
    required Color backgroundColor,
    required IconData icon,
    required String label,
  }) {
    return Row(
      children: [
        SizedBox(
          height: size,
          width: size,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(size * 0.2)),
            ),
            child: Icon(icon, size: 20),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(label),
      ],
    );
  }
}
