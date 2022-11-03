import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/controllers/timer_controller.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _pomodoroSecond = 60;
  bool _autoReplay = false;

  final _listPomodoroTimeOptions = <String>[
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
    _pomodoroSecond = _converTextTimeToSecond(
      _listPomodoroTimeOptions[_selectedPromodoroTime],
    );
    context.read<TimerController>().initialize(_pomodoroSecond);
    super.initState();
  }

  @override
  void dispose() {
    context.read<TimerController>().dispose();
    super.dispose();
  }

  void _handleSetDuration(int second) async {
    setState(() {
      _pomodoroSecond = second;
    });
    context.read<TimerController>().initialize(_pomodoroSecond);
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
    if (h != 0) result = '$result$h giờ ';
    if (m != 0) result = '$result$m phút ';
    if (s != 0) result = '$result$h giây';
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
          buildSwitchAuthBox(context),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildPromodoroSelectBox(),
          ),
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

  Container buildSwitchAuthBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.replay),
              const SizedBox(width: 10),
              Text(
                'Tự động lặp lại',
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                ),
              ),
            ],
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                _autoReplay = !_autoReplay;
              });
            },
            icon: Icon(
              _autoReplay ? Icons.toggle_on : Icons.toggle_off,
              size: 50,
              color:
                  _autoReplay ? Theme.of(context).focusColor : Colors.black87,
            ),
          )
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
                    'Thời gian làm việc',
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
              Text(
                _converSecondsToText(
                  _listPomodoroTimeOptions[_selectedPromodoroTime],
                ),
              )
            ],
          ),
        ),
        const Divider(),
        Wrap(
          runSpacing: 10.0, // column spacing
          spacing: 10.0, // row spacing
          children: _listPomodoroTimeOptions.map((e) {
            int index = _listPomodoroTimeOptions.indexOf(e);
            return IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: maxSizeImage,
                minHeight: maxSizeImage / 2,
              ),
              onPressed: () {
                final int second = _converTextTimeToSecond(
                  _listPomodoroTimeOptions[index],
                );
                _handleSetDuration(second);
                setState(() {
                  _selectedPromodoroTime = index;
                });
              },
              icon: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: index == _selectedPromodoroTime
                      ? Border.all(
                          color: Theme.of(context).focusColor, width: 3.0)
                      : Border.all(color: Colors.transparent, width: 0.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  _listPomodoroTimeOptions[index],
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
