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
  // int selectedScreenIndex = Provider.of<AppSettingsController>(context).selectedNavigationBar;
  int selectedScreenIndex = 0;
  void _handleOnItemTapped(int index) {
    setState(() {
      selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColorNavigationBar = Colors.black54;
    const selectedColorIcon = Colors.black;
    const selectedBackgroundColorIcon = Colors.teal;
    const animationDurationTap = Duration(milliseconds: 700);
    const colorLabel = Colors.teal;

    return Scaffold(
      body: Center(
        child: WorkspaceScreen._screenOptions.elementAt(selectedScreenIndex),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          // indicatorColor: selectedBackgroundColorIcon,
          // backgroundColor: backgroundColorNavigationBar,
          surfaceTintColor: Colors.red,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontWeight: FontWeight.bold,
              // color: colorLabel,
            ),
          ),
        ),
        child: NavigationBar(
          height: 65,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: animationDurationTap,
          onDestinationSelected: _handleOnItemTapped,
          selectedIndex: selectedScreenIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_work_outlined,
              ),
              selectedIcon: Icon(
                Icons.home_work,
                // color: selectedColorIcon,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.sticky_note_2_outlined,
              ),
              selectedIcon: Icon(
                Icons.sticky_note_2,
                // color: selectedColorIcon,
              ),
              label: 'Schedule',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.notifications,
                // color: selectedColorIcon,
              ),
              icon: Icon(
                Icons.notifications_outlined,
              ),
              label: 'Alarm',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.account_circle,
                // color: selectedColorIcon,
              ),
              icon: Icon(
                Icons.account_circle_outlined,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}