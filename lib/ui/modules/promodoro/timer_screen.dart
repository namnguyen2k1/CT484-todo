import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../state/controllers/timer_controller.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _promodoroSecond = 60;

  final _listPromodoroTimeOptions = <String>[
    '00:25:00',
    '00:30:00',
    '00:35:00',
    '00:40:00',
    '00:45:00',
    '01:00:00',
    '01:15:00',
    '01:30:00'
  ];

  int _selectedPromodoroTime = 0;

  @override
  void initState() {
    _promodoroSecond = _converTextTimeToSecond(
      _listPromodoroTimeOptions[_selectedPromodoroTime],
    );
    context.read<TimerController>().initialize(_promodoroSecond);
    super.initState();
  }

  @override
  void dispose() {
    context.read<TimerController>().dispose();
    super.dispose();
  }

  void _handleSetDuration(int second) async {
    setState(() {
      _promodoroSecond = second;
    });
    context.read<TimerController>().initialize(_promodoroSecond);
  }

  int _converTextTimeToSecond(String textTime) {
    final list = textTime.split(':');
    final int h = int.parse(list[0]);
    final int m = int.parse(list[1]);
    final int s = int.parse(list[2]);
    return h * 3600 + m * 60 + s;
  }

  String _converSecondsToText(String textTime) {
    final list = textTime.split(':');
    final int h = int.parse(list[0]);
    final int m = int.parse(list[1]);
    final int s = int.parse(list[2]);
    String result = '';
    if (h != 0) result = result + '$h giờ ';
    if (m != 0) result = result + '$m phút ';
    if (s != 0) result = result + '$h giây';
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final manager = context.read<TimerController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Promodoro Timer'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          ValueListenableProvider.value(
            value: manager.timeLeftNotifier,
            child: const TimerTextWidget(),
          ),
          const SizedBox(height: 20),
          ValueListenableProvider.value(
            value: manager.buttonStateNotifier,
            child: const ButtonsContainer(),
          ),
          const Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildPromodoroSelectBox(),
          ),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  context.read<TimerController>().reset();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_left),
                label: const Text('Back'),
              ),
            ],
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  Column buildPromodoroSelectBox() {
    const double maxSizeImage = 80;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.timelapse),
                  const SizedBox(width: 10),
                  Text(
                    'Duration Time',
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
              Text(
                _converSecondsToText(
                  _listPromodoroTimeOptions[_selectedPromodoroTime],
                ),
              )
            ],
          ),
        ),
        const Divider(),
        Wrap(
          runSpacing: 10.0, // column spacing
          spacing: 10.0, // row spacing
          children: _listPromodoroTimeOptions.map((e) {
            int index = _listPromodoroTimeOptions.indexOf(e);
            return IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: maxSizeImage,
                minHeight: maxSizeImage / 2,
              ),
              onPressed: () {
                final int second = _converTextTimeToSecond(
                  _listPromodoroTimeOptions[index],
                );
                _handleSetDuration(second);
                setState(() {
                  _selectedPromodoroTime = index;
                });
              },
              icon: Container(
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: index == _selectedPromodoroTime
                      ? Border.all(
                          color: Theme.of(context).focusColor, width: 2.0)
                      : Border.all(color: Colors.transparent, width: 0.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  _listPromodoroTimeOptions[index],
                  style: TextStyle(
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const Divider(),
      ],
    );
  }
}

class TimerTextWidget extends StatelessWidget {
  const TimerTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<String>(
      builder: (context, timeLeft, child) {
        return buildPromodoroTimer(
          context,
          timeLeft,
        );
      },
    );
  }

  Container buildPromodoroTimer(BuildContext context, String timerText) {
    final listCurrentTime = timerText.split(':');
    const double numberSize = 60;
    const double timeWidth = 100;
    const double timeHeight = 70;
    final Color numberColor = Theme.of(context).focusColor;

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: numberSize,
      fontWeight: FontWeight.bold,
    );
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: timeWidth,
            height: timeHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: numberColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              listCurrentTime[0],
              style: textStyle,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: timeWidth,
            height: timeHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: numberColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              listCurrentTime[1],
              style: textStyle,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: timeWidth,
            height: timeHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: numberColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              listCurrentTime[2],
              style: textStyle,
            ),
          )
        ],
      ),
    );
  }

  //
}

class ButtonsContainer extends StatelessWidget {
  const ButtonsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
      builder: (context, buttonState, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (buttonState == ButtonState.initial) const StartButton(),
            if (buttonState == ButtonState.started) ...[
              const PauseButton(),
              const SizedBox(width: 20),
              const ResetButton()
            ],
            if (buttonState == ButtonState.paused) ...[
              const StartButton(),
              const SizedBox(width: 20),
              const ResetButton()
            ],
            if (buttonState == ButtonState.finished) const ResetButton()
          ],
        );
      },
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<TimerController>().start();
      },
      child: const Icon(Icons.play_arrow),
    );
  }
}

class PauseButton extends StatelessWidget {
  const PauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<TimerController>().pause();
      },
      child: const Icon(Icons.pause),
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<TimerController>().reset();
      },
      child: const Icon(Icons.replay),
    );
  }
}
