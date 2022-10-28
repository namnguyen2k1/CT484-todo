import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todoapp/ui/modules/category/category_item.dart';
import 'package:todoapp/ui/modules/task/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _listCategory = [
    {
      "id": 1,
      "title": "Study",
      "color": "4294940672",
      "code": "001",
      "description": "Hoc an hoc noi hoc goi hoc mo"
    },
    {
      "id": 2,
      "title": "Eat",
      "code": "002",
      "color": "4278238420",
      "description": "An va ngu la dieu khong the thieu"
    },
    {
      "id": 3,
      "title": "Relax",
      "code": "003",
      "color": "4283215696",
      "description": "Thu gian hop ly giup tang cuong suc khoe"
    }
  ];

  DateTime _selectedDate = DateTime.now();

  String _convertDateInLocalArea({
    required DateTime time,
    String prefix = '/',
    area = 'vi',
  }) {
    final String day = time.day.toString();
    final String month = time.month.toString();
    final String year = time.year.toString();
    if (area == 'vi') {
      return '$day$prefix$month$prefix$year';
    } else if (area == 'eng') {
      return '$day$prefix$month$prefix$year';
    }

    return '__${prefix}__${prefix}__';
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final double widthCategory = deviceSize.width * 0.5;
    const double heightCategory = 150.00;

    return Scaffold(
      appBar: buildHomeScreenAppBar(context),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.view_comfortable),
                    const SizedBox(width: 10),
                    Text('Category (${_listCategory.length})'),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/workspace/home/category');
                  },
                  child: const Icon(Icons.create_new_folder),
                )
              ],
            ),
          ),
          buildListCategory(heightCategory, widthCategory),
          buildCurrentTask(),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                      _convertDateInLocalArea(time: _selectedDate, area: 'vi'),
                    ),
                  ],
                ),
                TextButton(
                  child: const Icon(Icons.manage_search),
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
          buildTaskDaily(),
        ],
      ),
    );
  }

  AppBar buildHomeScreenAppBar(BuildContext context) {
    return AppBar(
      title: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Hello, ",
            ),
            TextSpan(
              text: "Nguyen Anh Nam",
              style: TextStyle(color: Colors.teal),
            ),
          ],
        ),
      ),
      actions: [
        Stack(
          children: [
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).bottomAppBarColor,
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

  Container buildCurrentTask() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: const Text(
              'Đang diễn ra',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ),
          const TaskItem(
            content: "Hello",
          ),
        ],
      ),
    );
  }

  Container buildTaskDaily() {
    return Container(
      padding: const EdgeInsets.only(left: 20),
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
          // const SizedBox(
          //   width: 30,
          // ),
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
    );
  }

  Container buildListCategory(double heightCategory, double widthCategory) {
    List<Widget> listWidgetCategory = [];

    for (var item in _listCategory) {
      // print(item['id'].toString());
      listWidgetCategory.add(CategoryItem(
        category: item,
        widthItem: widthCategory,
      ));
    }
    return Container(
      padding: const EdgeInsets.all(10),
      height: heightCategory,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: listWidgetCategory,
      ),
    );
  }
}
