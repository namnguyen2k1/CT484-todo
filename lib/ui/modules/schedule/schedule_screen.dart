import 'package:flutter/material.dart';
import 'package:todoapp/ui/modules/category/category_item.dart';
import 'package:todoapp/ui/modules/tip/tip_item.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';

import '../task/task_item.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTask = -1;
  int _selectedCategory = -1;
  late TabController _tabController;
  final int _initialIndex = 0;
  final int _tabsCount = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabsCount,
      initialIndex: _initialIndex,
      vsync: this,
    );

    _tabController.addListener(() {
      final int currentTab = _tabController.index;
      if (currentTab == 0) {
        setState(() {
          _selectedTask = -1;
        });
      } else if (currentTab == 1) {
        setState(() {
          _selectedCategory = -1;
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _listTask = FakeData.tasks;
  final List<Map<String, dynamic>> _listTip = FakeData.tips;
  final List<Map<String, dynamic>> _listCategory = FakeData.categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Managerment'),
        actions: [
          IconButton(
            onPressed: () => {
              setState(() {
                Navigator.pushNamed(context, '/workspace/schedule/search');
              })
            },
            icon: const Icon(Icons.search),
          ),
        ],
        bottom: buildTabBar(),
      ),
      floatingActionButton: createFloatingActionButtonForEachTab(
        currentTab: _tabController.index,
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          buildDailyTask(context),
          buildCategory(context),
          buildTaskTips()
        ],
      ),
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      controller: _tabController,
      padding: const EdgeInsets.all(10),
      labelPadding: EdgeInsets.zero,
      isScrollable: false,
      // labelColor: Colors.yellow,
      // indicatorColor: Colors.black,
      indicatorWeight: 2,
      // unselectedLabelColor: Colors.black,
      indicator: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: Colors.teal,
      ),
      tabs: [
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.today,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Today',
              ),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.category),
              SizedBox(
                width: 10,
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
                width: 10,
              ),
              Text('Tip'),
            ],
          ),
        )
      ],
    );
  }

  Widget? createFloatingActionButtonForEachTab({required int currentTab}) {
    if (currentTab == 0) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/workspace/schedule/todo');
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.post_add),
      );
    }
    if (currentTab == 1) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/workspace/home/category');
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.playlist_add),
      );
    }
    return null;
    // Not created fab for 2 index deliberately
  }

  ListView buildDailyTask(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: _listTask.length,
      itemBuilder: (BuildContext context, int index) {
        final bool isMatch = _selectedTask == index;
        return Container(
          padding: const EdgeInsets.all(10),
          width: deviceSize.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).backgroundColor,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedTask = index;
                    });
                  },
                  child: TaskItem(
                    item: _listTask[index],
                    focus: isMatch,
                  ),
                ),
              ),
              isMatch
                  ? buildTaskControlButton(context)
                  : const SizedBox(
                      width: 0,
                    ),
            ],
          ),
        );
      },
    );
  }

  Row buildTaskControlButton(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/workspace/schedule/todo',
                );
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                final bool? isAccept = await showConfirmDialog(
                  context,
                  'Bạn muốn xoá Task này?',
                  'Hành động không thể phục hồi',
                );
                if (isAccept != false) {
                  print('delete task');
                }
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                if (_selectedTask == 0) return;
                setState(() {
                  _selectedTask = _selectedTask - 1;
                });
              },
              icon: const Icon(
                Icons.arrow_circle_up,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                if (_selectedTask == _listTask.length - 1) return;
                setState(() {
                  _selectedTask = _selectedTask + 1;
                });
              },
              icon: const Icon(
                Icons.arrow_circle_down,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ListView buildCategory(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: _listCategory.length,
      itemBuilder: (BuildContext context, int index) {
        final bool isMatch = _selectedCategory == index;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = index;
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).backgroundColor,
                padding: EdgeInsets.zero,
              ),
              child: CategoryItem(
                category: _listCategory[index],
                widthItem:
                    isMatch ? deviceSize.width * 0.85 : deviceSize.width - 20,
                isHorizontal: false,
                focus: isMatch,
              ),
            ),
            isMatch
                ? Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/workspace/schedule/todo',
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () async {
                              final bool? isAccept = await showConfirmDialog(
                                  context,
                                  'Bạn muốn xoá Task này?',
                                  'Hành động không thể phục hồi');
                              if (isAccept != false) {
                                print('delete task');
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(
                    width: 0,
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
