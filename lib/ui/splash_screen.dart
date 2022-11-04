import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            CircularProgressIndicator(
              color: Theme.of(context).focusColor,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Đang tải...'),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
