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
          const TaskStatistical(),
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
                  const Text('Công việc hiện tại'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: listTask.isEmpty
                  ? const EmptyBox(message: 'Hiện chưa có công việc')
                  : TaskItem(item: listTask[0]),
            ),
          ],
        );
      },
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
                  Text('Thể loại (${listCategory.length})'),
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
                  : const EmptyBox(message: 'Hiện chưa có thể loại'),
            )
          ],
        );
      },
    );
  }
}
