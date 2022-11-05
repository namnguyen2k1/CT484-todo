import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/category_controller.dart';

import 'package:todoapp/ui/modules/profile/profile_drawer.dart';
import 'package:todoapp/ui/shared/custom_dialog.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import '../../../state/controllers/auth_controller.dart';
import '../../../state/controllers/task_controller.dart';
import 'profile_information.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldAppSettingsKey =
      GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldAppSettingsKey.currentState!.openDrawer();
  }

  int _starCountFollowingTaskCompleted() {
    final tasks = context.read<TaskController>().allItems;
    print(tasks.length);
    var completedTask = 0;
    for (var element in tasks) {
      if (element.isCompleted == true) completedTask++;
    }
    print(completedTask);
    var starCount = 1;
    if (completedTask >= 10) starCount = 2;
    if (completedTask >= 50) starCount = 3;
    print(starCount);
    return 1;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double coverImageHeight = 200;
    return Scaffold(
      key: _scaffoldAppSettingsKey,
      drawer: const AppDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: 'Cài đặc',
                  onPressed: _openDrawer,
                ),
              ],
              title: const Text("Tổng Quan"),
              expandedHeight: 0,
              floating: false,
              snap: false,
              pinned: false,
            )
          ];
        },
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.grey,
                  child: Image.asset(
                    'assets/images/cover_image_2.jpg',
                    width: double.infinity,
                    height: coverImageHeight,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: buildProfileHeader(),
                )
              ],
            ),
            buildProfileInformations(),
            buildProfileControls(context),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }

  Row buildProfileHeader() {
    const double paddingSize = 2;
    const textShadow = <Shadow>[
      Shadow(
        // offset: Offset(0.0, 0.0),
        blurRadius: 3.0,
        color: Colors.white,
      ),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const WidgetCircularAnimator(
          size: 100,
          innerAnimation: Curves.bounceOut,
          outerAnimation: Curves.ease,
          innerColor: Colors.teal,
          outerColor: Colors.purpleAccent,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/avatar.gif'),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Text(
              'Nguyen Anh Nam',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color:
                    Theme.of(context).floatingActionButtonTheme.backgroundColor,
                shadows: textShadow,
              ),
            ),
            const SizedBox(
              width: paddingSize * 4,
            ),
            RateStar(starCount: _starCountFollowingTaskCompleted()),
          ],
        ),
      ],
    );
  }

  Container buildProfileInformations() {
    final tasks = context.read<TaskController>().allItems;
    final easy = tasks.where((element) => element.star == 1).toList().length;
    final medium = tasks.where((element) => element.star == 2).toList().length;
    final hard = tasks.where((element) => element.star == 3).toList().length;
    final tasksDone =
        tasks.where((element) => element.isCompleted == true).toList().length;
    final categories = context.read<CategoryController>().allItems;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const BuildTextInformation(
            icon: Icons.email,
            fieldTitle: 'Email',
            fieldContent: 'nanam133hg@gmail.com',
          ),
          const Divider(),
          const BuildTextInformation(
            icon: Icons.home,
            fieldTitle: 'Địa Chỉ',
            fieldContent: '../../../..',
          ),
          const Divider(),
          BuildTextInformation(
            icon: Icons.view_comfortable,
            fieldTitle: 'Tổng quan danh mục',
            fieldContent: '${categories.length} danh mục',
          ),
          const Divider(),
          BuildTextInformation(
            icon: Icons.task,
            fieldTitle: 'Tổng quan công việc',
            fieldContent: '$easy dễ, $medium trung bình, $hard khó',
          ),
          const Divider(),
          BuildFinishedTask(
            icon: Icons.task_alt,
            fieldTitle: 'Tiến độ làm việc',
            fieldContent: 'Đã hoàn thành $tasksDone việc',
          ),
        ],
      ),
    );
  }

  Container buildProfileControls(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Xoá tài khoản cục bộ',
                  style: TextStyle(color: Colors.red),
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      CustomDialog.showConfirm(
                        context,
                        'Xác nhận muốn xoá tài khoản?',
                        '*không thể phục hồi tài khoản',
                      );
                    },
                    icon: const Icon(
                      Icons.no_accounts,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Đăng xuất',
                  style: TextStyle(color: Colors.teal),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    context.read<AuthController>().logout();
                    print('[logout]');
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.teal,
                  ),
                )
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  //
}
