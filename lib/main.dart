import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todoapp/state/controllers/app_settings_controller.dart';
import 'package:todoapp/ui/routes/routes.dart' as route_config;

import './ui/screens.dart';
import './state/controllers/auth_controller.dart';

Future<void> main() async {
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
      ],
      child: Consumer2<AuthController, AppSettingsController>(
        builder: (ctx, authController, appSettingsController, child) {
          return MaterialApp(
            title: 'Todo App',
            debugShowCheckedModeBanner: false,
            theme: appSettingsController.isDarkTheme
                ? ThemeData.dark()
                : ThemeData.light(),
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
