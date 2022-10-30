import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:stream_duration/stream_duration.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todoapp/ui/modules/task/task_item.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';
import 'package:todoapp/ui/shared/notice_drawer.dart';
import 'package:todoapp/ui/shared/risk_text.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool _turnOnAlarm = true;
  int _currentTask = 0;

  final GlobalKey<ScaffoldState> _scaffoldAlarmKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldAlarmKey.currentState!.openDrawer();
  }

  final _listTask = FakeData.tasks;

  bool _isRunningTimer = true;
  final CountDownController _timerController = CountDownController();
  final _listPromodoroTip = <Map<String, dynamic>>[
    {"name": "Working Time", "content": "Lao dong la vinh quang"},
    {"name": "Short BreakTime", "content": "Nghi ngoi mot chut"},
    {"name": "Long BreakTime", "content": "Nghi ngoi mot lat"},
  ];
  int _countdownShortBreakTime = 3;
  final int _durationSecTimes = 3;

  int _selectedPromodoroTip = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double heightScroll = 190;
    const double lineWidth = 15;
    return Scaffold(
      key: _scaffoldAlarmKey,
      drawer: const AlarmDrawer(),
      appBar: buildAlarmAppBar(),
      body: ListView(
        children: [
          buildCurrentTask(),
          buildNextTask(heightScroll, lineWidth),
          buildPomodoro()
        ],
      ),
    );
  }

  Column buildPomodoro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.timer),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Pomoron Timer',
                    style: TextStyle(color: Colors.teal),
                  ),
                ],
              ),
              Row(
                children: [
                  _isRunningTimer
                      ? IconButton(
                          iconSize: 30,
                          onPressed: () {
                            _timerController.pause();
                            setState(() {
                              _isRunningTimer = false;
                            });
                            print('pause');
                          },
                          icon: const Icon(Icons.stop_circle),
                        )
                      : IconButton(
                          iconSize: 30,
                          onPressed: () {
                            _timerController.resume();
                            print('play');
                            setState(() {
                              _isRunningTimer = true;
                            });
                          },
                          icon: const Icon(Icons.play_circle),
                        ),
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      _timerController.restart();
                      _isRunningTimer = true;
                    },
                    icon: const Icon(Icons.restart_alt),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 20,
                right: 10,
              ),
              child: NeonCircularTimer(
                onStart: () {
                  setState(() {
                    if (_selectedPromodoroTip == 2) {
                      _selectedPromodoroTip = 0;
                      _countdownShortBreakTime = 3;
                    }

                    if (_countdownShortBreakTime == 0) {
                      _selectedPromodoroTip = 2;
                      return;
                    }

                    if (_selectedPromodoroTip == 0) {
                      _selectedPromodoroTip = 1;
                      _countdownShortBreakTime = _countdownShortBreakTime - 1;
                      return;
                    } else if (_selectedPromodoroTip == 1) {
                      _selectedPromodoroTip = 0;
                      return;
                    }
                  });
                },
                onComplete: () {
                  _timerController.restart();
                },
                textFormat: TextFormat.HH_MM_SS,
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                width: 100,
                controller: _timerController,
                duration: _durationSecTimes,
                strokeWidth: 10,
                isTimerTextShown: true,
                neumorphicEffect: false,
                // outerStrokeColor: Colors.grey.shade100,
                innerFillGradient: LinearGradient(colors: [
                  Colors.greenAccent.shade200,
                  Colors.blueAccent.shade400
                ]),
                neonGradient: LinearGradient(colors: [
                  Colors.greenAccent.shade200,
                  Colors.blueAccent.shade400
                ]),
                strokeCap: StrokeCap.round,
                innerFillColor: Colors.transparent,
                backgroudColor: Colors.transparent,
                neonColor: Colors.teal,
              ),
            ),
            Expanded(
              child: Container(
                height: 110,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedPromodoroTip == 0
                        ? Colors.green
                        : (_selectedPromodoroTip == 2
                            ? Colors.black
                            : Colors.grey),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        // border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                          _listPromodoroTip[_selectedPromodoroTip]['name']),
                    ),
                    RiskTextCustomt(
                      content: _listPromodoroTip[_selectedPromodoroTip]
                          ['content'],
                      lastIcon: Icons.edit,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  AppBar buildAlarmAppBar() {
    return AppBar(
      title: const Text('Task Notice'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Setting',
          onPressed: _openDrawer,
        ),
      ],
    );
  }

  Container buildNextTask(double heightScroll, double lineWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: heightScroll,
      child: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            width: heightScroll,
            child: CircularPercentIndicator(
              radius: (heightScroll - 2 * lineWidth) * 0.5,
              lineWidth: lineWidth,
              percent: 0.9,
              center: const Text(
                "01:30:00",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              backgroundColor: Colors.red,
              progressColor: Colors.green,
            ),
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.9),
                BlendMode.saturation,
              ),
              child: TaskItem(
                item: _listTask[_currentTask + 1],
                focus: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildCurrentTask() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Đang diễn ra',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ),
          TaskItem(item: _listTask[_currentTask], focus: false),
        ],
      ),
    );
  }

  Container buildTaskDaily(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            // color: Colors.black87,
            margin: const EdgeInsets.only(top: 10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: ClipPath(
              clipper: const ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                  border: Border(
                      // bottom: BorderSide(color: Colors.green, width: 3),
                      ),
                ),
                child: ListTile(
                  // contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Next Task On Day',
                    style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.circle_outlined,
                  ),
                  onTap: () {
                    showConfirmDialog(
                      context,
                      'Đánh dấu hoành thành công việc?',
                      'Chuyển sang việc tiếp theo',
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: const Text(
              'Sắp đến',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.book,
                size: 40,
              ),
              title: const Text('Learn Flutter'),
              subtitle: const Text('Học Fluter trong 1 tuần'),
              trailing: const Icon(Icons.info),
              onTap: () {
                showAlearDialog(
                  context,
                  'Learn Flutter',
                  'Flutter là một nền tảng đáng để học hỏi...',
                );
              },
            ),
          ),
          const Divider(),
          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.book,
                size: 40,
              ),
              title: const Text('Learn Flutter'),
              subtitle: const Text('Học Fluter trong 1 tuần'),
              trailing: const Icon(Icons.info),
              onTap: () {
                showAlearDialog(
                  context,
                  'Học Flutter',
                  'Flutter là một nền tảng đáng để học hỏi...',
                );
              },
            ),
          ),
          const Divider(),
          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.book,
                size: 40,
              ),
              title: const Text('Learn Flutter'),
              subtitle: const Text('Học Fluter trong 1 tuần'),
              trailing: const Icon(Icons.info),
              onTap: () {
                showAlearDialog(
                  context,
                  'Learn Flutter',
                  'Flutter là một nền tảng đáng để học hỏi...',
                );
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
