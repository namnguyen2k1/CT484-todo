import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/app_settings_controller.dart';

import 'package:todoapp/ui/modules/category/category_item.dart';
import 'package:todoapp/ui/modules/task/task_item.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import '../utilities/convert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _listCategory = FakeData.categories;
  final List<Map<String, dynamic>> _listTask = FakeData.tasks;

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
          buildCurrentTask(),
          buildTaskDaily(context),
        ],
      ),
    );
  }

  AppBar buildHomeScreenAppBar(BuildContext context) {
    // const text2 = Text.rich(
    //   TextSpan(
    //     children: [
    //       TextSpan(
    //         text: "Hello, ",
    //       ),
    //       TextSpan(
    //         text: "Nguyen Anh Nam",
    //         style: TextStyle(color: Colors.teal),
    //       ),
    //     ],
    //   ),
    // );
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
        Stack(
          children: [
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/avatar.gif'),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/workspace/profile');
              },
            ),
          ],
        )
      ],
    );
  }

  Column buildCurrentTask() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: const [
              Icon(Icons.pending),
              SizedBox(
                width: 10,
              ),
              Text('Đang diễn ra'),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TaskItem(
            item: _listTask[0],
            focus: false,
          ),
        ),
      ],
    );
  }

  Column buildTaskDaily(BuildContext context) {
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
              Expanded(
                child: CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: 0.9,
                  center: const Text(
                    "90%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  backgroundColor: Colors.red,
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
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Container(
                            color: Colors.deepPurple,
                            child: const Icon(
                              Icons.list,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('11 Task'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Container(
                            color: Colors.red,
                            child: const Icon(
                              Icons.pending,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('2 Task'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Container(
                            color: Colors.green,
                            child: const Icon(
                              Icons.done,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('9 Task'),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Container(
                            color: Colors.blue,
                            child: const Icon(
                              Icons.notification_important_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('5 task'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Container(
                            color: Colors.deepPurpleAccent,
                            child: const Icon(
                              Icons.notification_important_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('4 Task'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Container(
                            color: Colors.red,
                            child: const Icon(
                              Icons.notification_important_sharp,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('2 Task'),
                      ],
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

  Column buildListCategory(double heightCategory, double widthCategory) {
    List<Widget> listWidgetCategory = [];

    for (var item in _listCategory) {
      listWidgetCategory.add(CategoryItem(
        category: item,
        widthItem: widthCategory,
        isHorizontal: true,
        focus: false,
      ));
    }
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(Icons.view_comfortable),
              const SizedBox(width: 10),
              Text('Category (${_listCategory.length})'),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          height: heightCategory,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: listWidgetCategory,
          ),
        ),
      ],
    );
  }
}
