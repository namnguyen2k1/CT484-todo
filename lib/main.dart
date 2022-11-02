import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todoapp/state/controllers/app_settings_controller.dart';
import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/ui/routes/routes.dart' as route_config;

import './ui/screens.dart';
import './state/controllers/auth_controller.dart';

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
      ],
      child: Consumer2<AuthController, AppSettingsController>(
        builder: (ctx, authController, appSettingsController, child) {
          return MaterialApp(
            title: 'Todo App',
            debugShowCheckedModeBanner: false,
            theme: appSettingsController.isDarkTheme
                ? ThemeData.dark().copyWith(
                    primaryColor: Colors.black54,
                    backgroundColor: Colors.black54,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.black54,
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    tabBarTheme: TabBarTheme(
                      labelStyle: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.deepOrange,
                            width: 2.0,
                          )),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.white60,
                    ),
                    bottomAppBarColor: Colors.grey,
                    focusColor: Colors.deepOrange,
                    floatingActionButtonTheme:
                        const FloatingActionButtonThemeData(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.orange,
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                    ),
                    textSelectionTheme: const TextSelectionThemeData(
                      cursorColor: Colors.deepOrange,
                    ),
                    inputDecorationTheme: const InputDecorationTheme(
                      prefixIconColor: Colors.deepOrange,
                      suffixIconColor: Colors.deepOrange,
                      floatingLabelStyle:
                          TextStyle(color: Colors.deepOrange, fontSize: 20),
                      counterStyle:
                          TextStyle(color: Colors.deepOrange, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  )
                : ThemeData.light().copyWith(
                    primaryColor: Colors.white70,
                    backgroundColor: Colors.teal[900],
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    appBarTheme: AppBarTheme(
                      backgroundColor: Colors.teal[900],
                    ),
                    tabBarTheme: TabBarTheme(
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.green,
                            width: 2.0,
                          )),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                    ),
                    bottomAppBarColor: Colors.black54,
                    focusColor: Colors.green,
                    floatingActionButtonTheme:
                        const FloatingActionButtonThemeData(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.teal,
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                    ),
                    textSelectionTheme: const TextSelectionThemeData(
                      cursorColor: Colors.teal,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      prefixIconColor: Colors.teal[700],
                      suffixIconColor: Colors.teal[700],
                      floatingLabelStyle:
                          TextStyle(color: Colors.teal[700], fontSize: 20),
                      counterStyle:
                          TextStyle(color: Colors.teal[700], fontSize: 20),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.teal[700]!,
                        ),
                      ),
                    ),
                  ),
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
