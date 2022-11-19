import 'package:flutter/material.dart';
import '../screens.dart';

const String splashScreen = '/splash';
const String authScreen = '/auth';

const String homeScreen = '/workspace/home';
const String customCategoryScreen = '/workspace/home/category';

const String scheduleScreen = '/workspace/schedule';
const String customTodoScreen = '/workspace/schedule/todo';
const String scheduleSearchScreen = '/workspace/schedule/search';

const String alarmScreen = '/workspace/alarm';
const String alarmTimerScreen = '/workspace/alarm/timer';

const String profileScreen = '/workspace/profile';
const String profileSettingScreen = '/workspace/profile/setting';

const String workspaceScreen = '/workspace';

Route<dynamic> routeController(RouteSettings settings) {
  switch (settings.name) {
    case splashScreen:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case authScreen:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );
    case homeScreen:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

    case customCategoryScreen:
      return MaterialPageRoute(
        builder: (context) => EditCategoryScreen(null),
      );
    case scheduleScreen:
      return MaterialPageRoute(
        builder: (context) => const ScheduleScreen(),
      );
    case scheduleSearchScreen:
      return MaterialPageRoute(
        builder: (context) => const ScheduleSearchScreen(),
      );

    case customTodoScreen:
      return MaterialPageRoute(
        builder: (context) {
          return EditTaskScreen(null);
        },
      );

    case alarmScreen:
      return MaterialPageRoute(
        builder: (context) => const AlarmScreen(),
      );

    case alarmTimerScreen:
      return MaterialPageRoute(
        builder: (context) => const TimerScreen(),
      );
    case profileScreen:
      return MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      );

    case workspaceScreen:
      return MaterialPageRoute(
        builder: (context) => const WorkspaceScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const ErrorScreen(),
      );
  }
}
