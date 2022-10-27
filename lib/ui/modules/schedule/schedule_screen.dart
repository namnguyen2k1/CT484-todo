import 'package:flutter/material.dart';

import '../task/task_item.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool _showSearchField = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/workspace/schedule/todo_');
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
                      buildDailyTask(),
                      buildFavoriteTask(),
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
                Icon(Icons.favorite),
                SizedBox(
                  width: 5,
                ),
                Text('Yêu Thích'),
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

  ListView buildDailyTask() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: const TaskItem(
            content: "hello",
          ),
        ),
      ],
    );
  }

  ListView buildTaskTips() {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: const Text('Tip 1'),
        ),
        const Divider(),
        Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: const Text('Tip 1'),
        ),
      ],
    );
  }

  ListView buildFavoriteTask() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: const TaskItem(
            content: "hello",
          ),
        ),
      ],
    );
  }
}
