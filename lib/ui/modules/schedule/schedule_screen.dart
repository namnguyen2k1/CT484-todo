import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/ui/modules/schedule/list_category.dart';
import 'package:todoapp/ui/modules/schedule/list_task.dart';
import 'package:todoapp/ui/shared/custom_dialog.dart';
import 'package:todoapp/ui/modules/schedule/list_tip.dart';
import 'package:todoapp/ui/shared/top_right_badge.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
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
      setState(() {});
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
        title: const Text('Quản Lý Công Việc'),
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
        bottom: buildTabBar(context),
      ),
      floatingActionButton: createFloatingActionButton(
        currentTab: _tabController.index,
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ListTask(),
          ListCategory(),
          ListTipScreen(),
        ],
      ),
    );
  }

  TabBar buildTabBar(BuildContext context) {
    final taskController = context.watch<TaskController>();
    final categoryController = context.watch<CategoryController>();
    return TabBar(
      controller: _tabController,
      padding: const EdgeInsets.all(10),
      labelPadding: EdgeInsets.zero,
      isScrollable: false,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3.0,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor!,
        ),
        insets: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5,
        ),
      ),
      tabs: [
        Tab(
          child: SizedBox(
            width: 60,
            height: 50,
            child: TopRightBadge(
              data: taskController.allItems.length,
              child: Icon(
                Icons.task,
                color: Theme.of(context).focusColor,
                size: 35,
              ),
            ),
          ),
        ),
        Tab(
          child: SizedBox(
            width: 60,
            height: 50,
            child: TopRightBadge(
              data: categoryController.allItems.length,
              child: Icon(
                Icons.view_comfortable,
                color: Theme.of(context).focusColor,
                size: 35,
              ),
            ),
          ),
        ),
        Tab(
          icon: SizedBox(
            width: 60,
            height: 50,
            child: Icon(
              Icons.tips_and_updates,
              color: Theme.of(context).focusColor,
              size: 30,
            ),
          ),
        ),
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
          heroTag: "createTask",
          onPressed: () {
            if (categoryController.allItems.isEmpty) {
              CustomDialog.showAlert(
                context,
                'Không thêm tạo công việc khi chưa có danh mục',
                '*Vuốt qua phải và tạo danh mục mới',
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
          heroTag: "createCategory",
          onPressed: () {
            Navigator.pushNamed(context, '/workspace/home/category');
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.playlist_add),
        ),
      );
    }
    return null;
  }
}
