import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/category_controller.dart';
import '../../screens.dart';
import '../../shared/custom_dialog.dart';

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
    final categoryController = context.read<CategoryController>();
    return Scaffold(
      body: Center(
        child: WorkspaceScreen._screenOptions.elementAt(_selectedScreenIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (categoryController.allItems.isEmpty) {
            CustomDialog.showAlert(
              context,
              'Cant create task without creating category',
              'plese create new category!',
            );
          } else {
            Navigator.pushNamed(context, '/workspace/schedule/todo');
          }
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        activeColor: Theme.of(context).focusColor,
        inactiveColor: Theme.of(context).bottomAppBarColor,
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
