import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/ui/modules/task/task_item.dart';
import 'package:todoapp/ui/shared/empty_box.dart';
import '../../../state/models/task_model_change_notifier.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final GlobalKey<ScaffoldState> _scaffoldAlarmKey = GlobalKey<ScaffoldState>();
  final CountDownController _countDowncontroller = CountDownController();
  int secondsCount = 20;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alltasks = Provider.of<TaskController>(context).allItems;
    final listTasks =
        alltasks.where((element) => element.isCompleted == false).toList();
    return Scaffold(
      key: _scaffoldAlarmKey,
      appBar: buildAlarmAppBar(),
      body: ListView(
        children: [
          if (listTasks.isEmpty) ...[
            const EmptyBox(message: 'Hiện tại không có công việc')
          ],
          if (listTasks.length == 1) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTask(listTasks[0]),
                buildCircularTimer(listTasks[0], context),
              ],
            ),
          ] else if (listTasks.length >= 2) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTask(listTasks[0]),
                buildCircularTimer(listTasks[0], context),
                buildTask(listTasks[1], isCurentTask: false),
              ],
            ),
          ]
        ],
      ),
    );
  }

  NeonCircularTimer buildCircularTimer(TaskModel task, BuildContext context) {
    return NeonCircularTimer(
      width: 160,
      duration: int.parse(task.workingTime),
      isReverse: true,
      controller: _countDowncontroller,
      isTimerTextShown: true,
      textFormat: TextFormat.HH_MM_SS,
      strokeWidth: 15,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
      neumorphicEffect: false,
      innerFillGradient: LinearGradient(colors: [
        Theme.of(context).focusColor,
        Theme.of(context).floatingActionButtonTheme.backgroundColor!
      ]),
      neonGradient: LinearGradient(colors: [
        Theme.of(context).focusColor,
        Theme.of(context).floatingActionButtonTheme.backgroundColor!
      ]),
    );
  }

  Container buildTask(TaskModel task, {bool isCurentTask = true}) {
    const double paddingSize = 15;
    return Container(
      padding: const EdgeInsets.only(
        top: 0,
        right: paddingSize,
        left: paddingSize,
        bottom: paddingSize * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(paddingSize),
            child: Row(
              children: [
                Icon(isCurentTask ? Icons.query_builder : Icons.pending),
                const SizedBox(width: 10),
                Text(
                  isCurentTask ? 'Đang diễn ra' : 'Sắp tới',
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ],
            ),
          ),
          TaskItem(
            item: task,
          ),
        ],
      ),
    );
  }

  AppBar buildAlarmAppBar() {
    return AppBar(
      title: const Text('Quản lý tiến độ công việc'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.self_improvement),
          tooltip: 'Pomodoro',
          onPressed: () {
            Navigator.pushNamed(
              _scaffoldAlarmKey.currentContext!,
              '/workspace/alarm/timer',
            );
          },
        ),
      ],
    );
  }
}
