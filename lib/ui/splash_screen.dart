import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final colorizeColors = [
    Colors.teal,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  final colorizeTextStyle = const TextStyle(
    fontSize: 35.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'TodoList',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.task_alt,
                  size: 40,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  'Manage Your Team & Everything With Tasks',
                ),
              ],
              totalRepeatCount: 4,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          const CircularProgressIndicator(
            color: Colors.teal,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('loading...'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
