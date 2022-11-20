import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todoapp/state/models/category_model_change_notifier.dart';
import 'package:todoapp/state/models/task_model_change_notifier.dart';

import './state/controllers/app_settings_controller.dart';
import './state/controllers/category_controller.dart';
import './state/controllers/task_controller.dart';
import './state/controllers/timer_controller.dart';
import './state/controllers/auth_controller.dart';

import './ui/routes/routes.dart' as route_config;
import './ui/screens.dart';
import './ui/themes/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final categoryController = CategoryController();
  final taskController = TaskController();
  // Load local resources
  await categoryController.getAllCategories();
  await taskController.getAllTasks();

  // Load env
  await dotenv.load();
  runApp(MyApp(
    tasks: taskController,
    categories: categoryController,
  ));
}

class MyApp extends StatelessWidget {
  final TaskController tasks;
  final CategoryController categories;
  const MyApp({
    super.key,
    required this.tasks,
    required this.categories,
  });
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AppSettingsController(),
        ),
        ChangeNotifierProvider.value(
          value: categories,
        ),
        ChangeNotifierProvider.value(
          value: tasks,
        ),
        ChangeNotifierProvider(
          create: (ctx) => TimerController(),
        ),
      ],
      child: Consumer2<AuthController, AppSettingsController>(
        builder: (ctx, authController, appSettingsController, child) {
          return MaterialApp(
            title: 'Todo App',
            debugShowCheckedModeBanner: false,
            theme: appSettingsController.isDarkTheme
                ? AppTheme.dark
                : AppTheme.light,
            home: authController.isAuth
                ? const WorkspaceScreen()
                : FutureBuilder(
                    future: authController.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    },
                  ),
            onGenerateRoute: route_config.routeController,
          );
        },
      ),
    );
  }
}
