import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/app_settings_controller.dart';
import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/state/controllers/task_controller.dart';

import 'package:todoapp/ui/modules/category/category_item.dart';
import 'package:todoapp/ui/modules/task/task_item.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import '../../../state/models/task_model.dart';
import '../../shared/empty_box.dart';
import '../utilities/convert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _listTask = <TaskModel>[];

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final double widthCategory = deviceSize.width * 0.5;
    const double heightCategory = 150.00;

    return Scaffold(
      appBar: buildHomeScreenAppBar(context),
      body: ListView(
        children: [
          buildListCategory(heightCategory, widthCategory),
          buildCurrentTask(context),
          buildTaskStatistical(context),
        ],
      ),
    );
  }

  AppBar buildHomeScreenAppBar(BuildContext context) {
    return AppBar(
      title: Row(children: const [
        Text(
          'Nguyen Nam',
        ),
        SizedBox(
          width: 10,
        ),
        RateStar(starCount: 3)
      ]),
      actions: [
        TextButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/workspace/profile');
          },
          child: const WidgetCircularAnimator(
            size: 50,
            innerIconsSize: 1,
            outerIconsSize: 2,
            innerAnimation: Curves.bounceOut,
            outerAnimation: Curves.ease,
            innerColor: Colors.teal,
            outerColor: Colors.deepOrange,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/avatar.gif'),
            ),
          ),
        )
      ],
    );
  }

  Widget buildCurrentTask(BuildContext context) {
    return Consumer<TaskController>(
      builder: (context, taskController, child) {
        final listTask = taskController.allItems;

        return Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(
                    Icons.pending,
                    color: Theme.of(context).focusColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Đang diễn ra'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: listTask.isEmpty
                  ? const EmptyBox(message: 'No Task')
                  : TaskItem(item: listTask[0]),
            ),
          ],
        );
      },
    );
  }

  Column buildTaskStatistical(BuildContext context) {
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
                    convertDateInLocalArea(
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
                      label: "11 Task",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTotalTaskType(
                      size: 30,
                      icon: Icons.pending,
                      backgroundColor: Colors.red,
                      label: "2 Task",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTotalTaskType(
                      size: 30,
                      icon: Icons.done,
                      backgroundColor: Colors.green,
                      label: "9 Task",
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
                      label: "5 Task",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTotalTaskType(
                      size: 30,
                      icon: Icons.notification_important_outlined,
                      backgroundColor: Colors.deepPurpleAccent,
                      label: "4 Task",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTotalTaskType(
                      size: 30,
                      icon: Icons.notification_important,
                      backgroundColor: Colors.red,
                      label: "2 Task",
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

  Widget buildListCategory(double heightCategory, double widthCategory) {
    return Consumer<CategoryController>(
      builder: (context, categoryController, child) {
        final listCategory = categoryController.allItems;
        List<Widget> listWidgetCategory = [];

        if (listCategory.isNotEmpty) {
          for (var item in listCategory) {
            listWidgetCategory.add(
              CategoryItem(
                item,
                widthItem: widthCategory,
                isHorizontal: true,
              ),
            );
          }
        }

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(
                    Icons.view_comfortable,
                    color: Theme.of(context).focusColor,
                  ),
                  const SizedBox(width: 10),
                  Text('Category (${listCategory.length})'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: heightCategory,
              child: listCategory.isNotEmpty
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: listWidgetCategory,
                    )
                  : const EmptyBox(message: 'No Category'),
            )
          ],
        );
      },
    );
  }
}
