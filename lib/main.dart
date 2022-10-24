import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './ui/screens.dart';
import './ui/splash_screen.dart';
import 'state/controllers/auth_controller.dart';
import './ui/routes/routes.dart' as route_config;

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
        // ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
        //   create: (ctx) => ProductsManager(),
        //   update: (ctx, authManager, productsManager) {
        //     productsManager!.authToken = authManager.authToken;
        //     return productsManager;
        //   },
        // ),
      ],
      child: Consumer<AuthController>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'Todo App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(),
            home: authManager.isAuth
                ? const WorkspaceScreen()
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    },
                  ),
          );
        },
      ),
    );
  }
}
