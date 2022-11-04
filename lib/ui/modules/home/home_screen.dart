import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../../../state/controllers/category_controller.dart';
import '../../../state/controllers/task_controller.dart';

import '../category/category_item.dart';
import '../home/task_statistical.dart';
import '../task/task_item.dart';
import '../../shared/rate_star.dart';
import '../../shared/empty_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _starCountFollowingTaskCompleted() {
    final tasks = context.read<TaskController>().allItems;
    print(tasks.length);
    var completedTask = 0;
    for (var element in tasks) {
      if (element.isCompleted == true) completedTask++;
    }
    print(completedTask);
    var starCount = 1;
    if (completedTask >= 10) starCount = 2;
    if (completedTask >= 50) starCount = 3;
    print(starCount);
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final double widthCategory = deviceSize.width * 0.7;
    const double heightCategory = 170.00;

    return Scaffold(
      appBar: buildHomeScreenAppBar(context),
      body: ListView(
        children: [
          buildListCategory(heightCategory, widthCategory),
          buildCurrentTask(context),
          const TaskStatistical(),
        ],
      ),
    );
  }

  AppBar buildHomeScreenAppBar(BuildContext context) {
    return AppBar(
      title: Row(children: [
        const Text(
          'Nguyen Nam',
        ),
        const SizedBox(
          width: 10,
        ),
        RateStar(
          starCount: _starCountFollowingTaskCompleted(),
        ),
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
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/avatar.gif'),
          ),
        )
      ],
    );
  }

  Widget buildCurrentTask(BuildContext context) {
    final listTaskPending = context
        .read<TaskController>()
        .allItems
        .where((element) => element.isCompleted == false)
        .toList();
    final taskPending =
        listTaskPending.indexWhere((e) => e.isCompleted == false);
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
              const Text('Công việc hiện tại'),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: listTaskPending.isEmpty
              ? const EmptyBox(message: 'Hiện chưa có công việc mới')
              : TaskItem(item: listTaskPending[taskPending]),
        ),
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
                  Text('Danh mục (${listCategory.length})'),
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
                  : const EmptyBox(message: 'Hiện chưa có danh mục'),
            )
          ],
        );
      },
    );
  }
}
