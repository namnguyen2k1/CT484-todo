import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/app_settings_controller.dart';

import 'package:todoapp/state/controllers/auth_controller.dart';
import 'package:todoapp/state/services/auth_service.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';

import 'auth_card.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _listQuickAccount = <Map<String, dynamic>>[];

  @override
  void initState() {
    _loadAllLocalAccount();
    super.initState();
  }

  Future<void> _loadAllLocalAccount() async {
    final accounts = await AuthService().getAllLocalAccounts();
    setState(() {
      _listQuickAccount = accounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorizeColors = [
      Colors.teal,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 35.0,
    );
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    'TodoList App',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
          ),
          const AuthCard(),
          buildQuickLogin(),
        ],
      ),
    );
  }

  Container buildQuickLogin() {
    List<Widget> listWidgetLogin = [];

    for (var item in _listQuickAccount) {
      listWidgetLogin.add(
        buildQuickLoginItem(email: item['email']!, password: item['password']!),
      );
      listWidgetLogin.add(
        const SizedBox(
          height: 10,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const Divider(),
          const Text('Quick Login'),
          const Divider(),
          ...listWidgetLogin,
        ],
      ),
    );
  }

  Row buildQuickLoginItem({required String email, required String password}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.account_circle),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  email,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () async {
                print('[Remove] $email');
                final isAccepted = await showConfirmDialog(
                  context,
                  'Remove this account from your device?',
                  "*Bạn phải nhập lại thông tin ở lần đăng nhập sau.",
                );
                if (isAccepted != false) {
                  if (mounted) {
                    context.read<AuthController>().removeLocalAccount(email);
                  }
                }
              },
              icon: const Icon(Icons.delete),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                print('[Login]: $email');
                context.read<AuthController>().login(email, password);
              },
              icon: const Icon(Icons.login),
            ),
          ],
        ),
      ],
    );
  }
}
