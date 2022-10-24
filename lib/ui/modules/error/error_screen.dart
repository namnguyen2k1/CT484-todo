import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  static const routeName = '/error';
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Something Wrong!'),
      ),
    );
  }
}
