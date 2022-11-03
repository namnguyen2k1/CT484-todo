import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
        ChangeNotifierProvider(
          create: (ctx) => CategoryController(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TaskController(),
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
