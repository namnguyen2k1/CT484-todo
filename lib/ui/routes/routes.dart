import 'package:flutter/material.dart';
import '../screens.dart';

const String splashScreen = '/splash';
const String authScreen = '/auth';

const String homeScreen = '/workspace/home';
const String customCategoryScreen = '/workspace/home/category';

const String scheduleScreen = '/workspace/schedule';
const String customTodoScreen = '/workspace/schedule/todo';

const String alarmScreen = '/workspace/alarm';

const String profileScreen = '/workspace/profile';
const String editProfileScreen = '/workspace/profile/edit';

const String profileSettingScreen = '/workspace/profile/setting';

const String workspaceScreen = '/workspace';

// Control our page route flow
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
        builder: (context) => const EditCategoryScreen(),
      );
    case scheduleScreen:
      return MaterialPageRoute(
        builder: (context) => const ScheduleScreen(),
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
    case profileScreen:
      return MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      );

    case editProfileScreen:
      return MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
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
