import 'package:flutter/material.dart';
import 'package:todoapp/ui/modules/category/category_item.dart';
import 'package:todoapp/ui/modules/tip/tip_item.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';

import '../task/task_item.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool _showSearchField = false;

  final List<Map<String, dynamic>> _listTask = FakeData.tasks;
  final List<Map<String, dynamic>> _listTip = FakeData.tips;
  final List<Map<String, dynamic>> _listCategory = FakeData.categories;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: buildScheduleAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/workspace/schedule/todo');
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.post_add_sharp),
      ),
      body: ListView(
        children: [
          DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildAppBar(),
                Container(
                  height: deviceSize.height - 210, //height of TabBarView
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        // color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: TabBarView(
                    children: <Widget>[
                      buildDailyTask(context),
                      buildCategory(context),
                      buildTaskTips()
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildScheduleAppBar() {
    return AppBar(
      title: _showSearchField
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _showSearchField = false;
                      });
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            )
          : Row(
              children: const [
                Text('Task Managerment'),
              ],
            ),
      actions: [
        !_showSearchField
            ? IconButton(
                onPressed: () => {
                  setState(() {
                    _showSearchField = true;
                  })
                },
                icon: const Icon(Icons.search),
              )
            : const Text(""),
      ],
    );
  }

  Container buildAppBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      child: TabBar(
        isScrollable: false,
        // labelColor: Colors.yellow,
        // indicatorColor: Colors.black,
        indicatorWeight: 2,
        // unselectedLabelColor: Colors.black,
        indicator: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          color: Colors.teal,
        ),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.today),
                SizedBox(
                  width: 5,
                ),
                Text('Today'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.category),
                SizedBox(
                  width: 5,
                ),
                Text('Category'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.tips_and_updates),
                SizedBox(
                  width: 5,
                ),
                Text('Tip'),
              ],
            ),
          )
        ],
      ),
    );
  }

  ListView buildDailyTask(BuildContext context) {
    return ListView.builder(
      itemCount: _listTask.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Expanded(
            child: TaskItem(
              item: _listTask[index],
            ),
          ),
        );
      },
    );
  }

  ListView buildCategory(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: _listCategory.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            CategoryItem(
              category: _listCategory[index],
              widthItem: deviceSize.width,
              isHorizontal: false,
            ),
          ],
        );
      },
      padding: const EdgeInsets.all(10),
    );
  }

  ListView buildTaskTips() {
    List<Widget> listItem = <Widget>[];

    for (var item in _listTip) {
      listItem.add(TipItem(tip: item));
      listItem.add(const Divider());
    }

    return ListView(
      padding: const EdgeInsets.all(10),
      children: listItem,
    );
  }
}
