import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/state/models/task_model.dart';
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

  final List<Map<String, dynamic>> _listTip = FakeData.tips;

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
          _selectedCategory = -1;
        });
      } else if (currentTab == 1) {
        setState(() {
          _selectedTask = -1;
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
      indicatorWeight: 2,
      unselectedLabelColor: Colors.black,
      indicator: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: Theme.of(context).primaryTextTheme.titleLarge!.color,
      ),
      tabs: [
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.today,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Today',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.category,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Category',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.tips_and_updates,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Tip',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget? createFloatingActionButtonForEachTab({required int currentTab}) {
    if (currentTab == 0) {
      return RippleAnimation(
        color: Colors.teal,
        repeat: true,
        minRadius: 30,
        ripplesCount: 6,
        child: FloatingActionButton(
          heroTag: "button1",
          onPressed: () {
            Navigator.pushNamed(context, '/workspace/schedule/todo');
          },
          backgroundColor: Colors.teal,
          child: const Icon(Icons.post_add),
        ),
      );
    }
    if (currentTab == 1) {
      return RippleAnimation(
        color: Colors.deepOrange,
        repeat: true,
        minRadius: 30,
        ripplesCount: 6,
        child: FloatingActionButton(
          heroTag: "button2",
          onPressed: () {
            Navigator.pushNamed(context, '/workspace/home/category');
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.playlist_add),
        ),
      );
    }
    return null;
    // Not created fab for 2 index deliberately
  }

  Widget buildDailyTask(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Consumer<TaskController>(
      builder: (context, taskController, child) {
        final listTask = taskController.allItems;
        print('local task: ${listTask.toString()}');
        return ListView.builder(
          itemCount: listTask.length,
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
                        item: listTask[index],
                        focus: isMatch,
                      ),
                    ),
                  ),
                  isMatch
                      ? buildTaskControlButton(context, listTask, index)
                      : const SizedBox(
                          width: 0,
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Row buildTaskControlButton(
      BuildContext context, List<TaskModel> listTask, int index) {
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
                  context.read<TaskController>().deleteItemById(
                        listTask[index].id,
                      );
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
                if (_selectedTask == listTask.length - 1) return;
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

  Widget buildCategory(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Consumer<CategoryController>(
      builder: (context, categoryController, child) {
        final listCategory = categoryController.allItems;
        print('local category: ${listCategory.toString()}');
        return ListView.builder(
          itemCount: listCategory.length,
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
                    item: listCategory[index],
                    widthItem: isMatch
                        ? deviceSize.width * 0.85
                        : deviceSize.width - 20,
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
                                  final bool? isAccept =
                                      await showConfirmDialog(
                                          context,
                                          'Bạn muốn xoá Task này?',
                                          'Hành động không thể phục hồi');
                                  if (isAccept != false) {
                                    print('delete task');
                                    await categoryController.deleteItem(
                                      listCategory[index].id,
                                    );
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
      },
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
