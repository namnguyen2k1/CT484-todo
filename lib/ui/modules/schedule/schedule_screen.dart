import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/ui/modules/schedule/list_category.dart';
import 'package:todoapp/ui/modules/schedule/list_task.dart';
import 'package:todoapp/ui/shared/custom_dialog.dart';
import 'package:todoapp/ui/modules/schedule/list_tip.dart';

import '../../shared/custom_snackbar.dart';

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
        bottom: buildTabBar(),
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

  TabBar buildTabBar() {
    return TabBar(
      controller: _tabController,
      padding: const EdgeInsets.all(10),
      labelPadding: EdgeInsets.zero,
      isScrollable: false,
      indicatorWeight: 2,
      tabs: const [
        Tab(child: Text('Công việc')),
        Tab(child: Text('Danh mục')),
        Tab(child: Text('Mẹo')),
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
                'Không thêm tạo thêm công việc khi chưa có danh mục',
                '*Vuốt qua phải và tạo mới danh mục',
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
