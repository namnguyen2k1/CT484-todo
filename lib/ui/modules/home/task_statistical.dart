import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../state/controllers/app_settings_controller.dart';
import '../utilities/format_time.dart';

class TaskStatistical extends StatefulWidget {
  const TaskStatistical({super.key});

  @override
  State<TaskStatistical> createState() => _TaskStatisticalState();
}

class _TaskStatisticalState extends State<TaskStatistical> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appSettingsController = Provider.of<AppSettingsController>(context);
    final settingLanguage =
        appSettingsController.isEnglishLanguage ? 'eng' : 'vi';
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.date_range),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    formatTimeLocalArea(
                      time: _selectedDate,
                      area: settingLanguage,
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.manage_search),
                onPressed: () async {
                  final currentDate = DateTime.now();
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: currentDate,
                    lastDate: DateTime(currentDate.year + 2),
                  );
                  setState(() {
                    _selectedDate = selectedDate!;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: 0.9,
                  center: Text(
                    "90%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).focusColor,
                      fontSize: 20.0,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  progressColor: Colors.green,
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
                      label: "11 việc",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTotalTaskType(
                      size: 30,
                      icon: Icons.pending,
                      backgroundColor: Colors.red,
                      label: "2 việc",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTotalTaskType(
                      size: 30,
                      icon: Icons.done,
                      backgroundColor: Colors.green,
                      label: "9 việc",
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
                      label: "5 việc",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTotalTaskType(
                      size: 30,
                      icon: Icons.notification_important_outlined,
                      backgroundColor: Colors.deepPurpleAccent,
                      label: "4 việc",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTotalTaskType(
                      size: 30,
                      icon: Icons.notification_important,
                      backgroundColor: Colors.red,
                      label: "2 việc",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
