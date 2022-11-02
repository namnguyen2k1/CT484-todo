import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/ui/modules/task/task_item.dart';
import 'package:todoapp/ui/screens.dart';
import 'package:todoapp/ui/shared/empty_box.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final GlobalKey<ScaffoldState> _scaffoldAlarmKey = GlobalKey<ScaffoldState>();
  int _currentTask = 0;

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
    const double heightScroll = 190;
    const double lineWidth = 15;
    return Scaffold(
      key: _scaffoldAlarmKey,
      appBar: buildAlarmAppBar(),
      body: ListView(
        children: [
          buildCurrentTaskTimer(heightScroll, lineWidth),
        ],
      ),
    );
  }

  AppBar buildAlarmAppBar() {
    return AppBar(
      title: const Text('Task Notice'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.self_improvement),
          tooltip: 'Setting',
          onPressed: () {
            Navigator.pushNamed(
              _scaffoldAlarmKey.currentContext!,
              '/workspace/alarm/promodoro',
            );
          },
        ),
      ],
    );
  }

  Widget buildCurrentTaskTimer(double heightScroll, double lineWidth) {
    const double paddingSize = 15;
    return Consumer<TaskController>(
      builder: (context, taskController, child) {
        final listTasks = taskController.allItems;
        if (listTasks.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
                        children: const [
                          Icon(Icons.build),
                          SizedBox(width: 10),
                          Text(
                            'Đang diễn ra',
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (listTasks.isNotEmpty)
                      TaskItem(
                        item: listTasks[_currentTask],
                      ),
                  ],
                ),
              ),
              CircularPercentIndicator(
                radius: (heightScroll - 2 * lineWidth) * 0.5,
                lineWidth: lineWidth,
                percent: 0.9,
                center: const Text(
                  "01:30:00",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                backgroundColor: Colors.red,
                progressColor: Colors.green,
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 0,
                  left: paddingSize,
                  right: paddingSize,
                  bottom: paddingSize,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(paddingSize),
                      child: Row(
                        children: const [
                          Icon(Icons.pending),
                          SizedBox(width: 10),
                          Text(
                            'Sắp tới',
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (listTasks.isNotEmpty)
                      TaskItem(
                        item: listTasks[_currentTask + 1],
                      ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const EmptyBox(
              message: 'Not Current Task. Lets create new task!');
        }
      },
    );
  }
}
