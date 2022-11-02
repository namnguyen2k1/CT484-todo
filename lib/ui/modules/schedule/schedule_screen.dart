import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/state/models/category_model.dart';
import 'package:todoapp/state/models/task_model.dart';
import 'package:todoapp/ui/modules/category/category_item.dart';
import 'package:todoapp/ui/modules/category/edit_category_screen.dart';
import 'package:todoapp/ui/modules/schedule/list_tip_screen.dart';
import 'package:todoapp/ui/modules/task/edit_task_screen.dart';
import 'package:todoapp/ui/modules/tip/tip_item.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';
import 'package:todoapp/ui/shared/empty_box.dart';
import 'package:todoapp/ui/shared/response_message.dart';

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
      floatingActionButton: createFloatingActionButton(
        currentTab: _tabController.index,
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          buildDailyTaskTabBody(context),
          buildCategoryTabBody(context),
          const ListTipScreen(),
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
      tabs: const [
        Tab(child: Text('Task')),
        Tab(child: Text('Category')),
        Tab(child: Text('Tip')),
      ],
    );
  }

  Widget? createFloatingActionButton({required int currentTab}) {
    if (currentTab == 0) {
      final categoryController = context.read<CategoryController>();
      return RippleAnimation(
        color: Colors.teal,
        repeat: true,
        minRadius: 30,
        ripplesCount: 6,
        child: FloatingActionButton(
          heroTag: "button1",
          onPressed: () {
            if (categoryController.allItems.isEmpty) {
              showAlearDialog(
                context,
                'Cant create task without creating category',
                'swiper right and create new category',
              );
            } else {
              Navigator.pushNamed(context, '/workspace/schedule/todo');
            }
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

  Widget buildDailyTaskTabBody(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Consumer<TaskController>(
      builder: (context, taskController, child) {
        final listTask = taskController.allItems;
        print('local task');
        for (var item in listTask) {
          print(item.toString());
        }
        return listTask.isNotEmpty
            ? ListView.builder(
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
                              foregroundColor:
                                  Theme.of(context).backgroundColor,
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedTask = index;
                              });
                            },
                            child: TaskItem(
                              // bug item
                              item: listTask[index],
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
              )
            : const EmptyBox(message: 'No Task');
      },
    );
  }

  Row buildTaskControlButton(
      BuildContext context, List<TaskModel> listTask, int index) {
    final taskController = context.read<TaskController>();
    const EdgeInsetsGeometry paddingButton = EdgeInsets.all(5.0);
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            IconButton(
              padding: paddingButton,
              constraints: const BoxConstraints(),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(listTask[index]),
                  ),
                );
                // re-build task
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
            IconButton(
              padding: paddingButton,
              constraints: const BoxConstraints(),
              onPressed: () async {
                final bool? isAccept = await showConfirmDialog(
                  context,
                  'Bạn muốn xoá Task này?',
                  'Hành động không thể phục hồi',
                );
                if (isAccept != false) {
                  await taskController.deleteItemById(
                    listTask[index].id,
                  );
                }
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
            IconButton(
              padding: paddingButton,
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
            IconButton(
              padding: paddingButton,
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

  Widget buildCategoryTabBody(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Consumer<CategoryController>(
      builder: (context, categoryController, child) {
        final listCategory = categoryController.allItems;
        print('local task');
        for (var item in listCategory) {
          print(item.toString());
        }
        return listCategory.isNotEmpty
            ? ListView.builder(
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
                          listCategory[index],
                          widthItem: isMatch
                              ? deviceSize.width * 0.85
                              : deviceSize.width - 20,
                          isHorizontal: false,
                        ),
                      ),
                      isMatch
                          ? buildCategoryControlButton(
                              context,
                              listCategory,
                              index,
                            )
                          : const SizedBox(
                              width: 0,
                            ),
                    ],
                  );
                },
                padding: const EdgeInsets.all(10),
              )
            : const EmptyBox(message: 'No Category');
      },
    );
  }

  Row buildCategoryControlButton(
    BuildContext context,
    List<CategoryModel> listCategory,
    int index,
  ) {
    final categoryController = context.read<CategoryController>();
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
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditCategoryScreen(
                      listCategory[index],
                    ),
                  ),
                );
                // re-build category
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
                final bool? isAccept = await showConfirmDialog(context,
                    'Bạn muốn xoá Task này?', 'Hành động không thể phục hồi');
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
    );
  }
}
