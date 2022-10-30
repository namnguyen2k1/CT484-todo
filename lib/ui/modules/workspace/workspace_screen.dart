import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../screens.dart';

class WorkspaceScreen extends StatefulWidget {
  static const routeName = '/workspace';

  static const List<Widget> _screenOptions = <Widget>[
    HomeScreen(),
    ScheduleScreen(),
    AlarmScreen(),
    ProfileScreen()
  ];

  const WorkspaceScreen({super.key});

  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  // int _selectedScreenIndex = Provider.of<AppSettingsController>(context).selectedNavigationBar;
  int _selectedScreenIndex = 0;
  void _handleOnItemTapped(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  final List<IconData> _listIcon = [
    Icons.home_work,
    Icons.sticky_note_2,
    Icons.notifications,
    Icons.account_circle
  ];

  @override
  Widget build(BuildContext context) {
    const backgroundColorNavigationBar = Colors.black54;
    const selectedColorIcon = Colors.black;
    const selectedBackgroundColorIcon = Colors.teal;
    const animationDurationTap = Duration(milliseconds: 700);
    const colorLabel = Colors.teal;

    return Scaffold(
      body: Center(
        child: WorkspaceScreen._screenOptions.elementAt(_selectedScreenIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/workspace/schedule/todo');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        activeColor: Colors.deepOrange,
        icons: _listIcon,
        activeIndex: _selectedScreenIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 30,
        rightCornerRadius: 30,
        onTap: (index) {
          _handleOnItemTapped(index);
        },
        //other params
      ),
    );
  }
}
