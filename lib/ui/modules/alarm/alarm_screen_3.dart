import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:todoapp/ui/modules/task/task_item.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool _turnOnAlarm = true;
  int _currentTask = 0;
  late final StreamDuration _streamDuration;

  final _listTask = FakeData.tasks;

  bool _isRunningTimer = true;

  void _handleOnEndTimer() {
    setState(() {
      _isRunningTimer = false;
    });
    print('end..');
  }

  @override
  void initState() {
    _streamDuration = StreamDuration(
      const Duration(
        hours: 10,
      ),
      onDone: () {
        print('on done');
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _streamDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double heightScroll = 190;
    const double lineWidth = 15;
    return Scaffold(
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
          child: const Text(
            'Pomorono',
            style: TextStyle(color: Colors.teal),
          ),
        ),
        const Divider(),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey, width: 0.5),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: SlideCountdownSeparated(
                    width: 50,
                    duration: const Duration(
                      hours: 0,
                      minutes: 0,
                      seconds: 10,
                    ),
                    showZeroValue: true,
                    streamDuration: _streamDuration,
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )
                    // suffixIcon: Icon(Icons.timer),
                    ),
              ),
            ),
            _isRunningTimer
                ? IconButton(
                    onPressed: () {
                      _streamDuration.pause();
                      setState(() {
                        _isRunningTimer = false;
                      });
                      print('pause');
                    },
                    icon: const Icon(Icons.stop_circle),
                  )
                : IconButton(
                    onPressed: () {
                      _streamDuration.resume();
                      print('play');
                      setState(() {
                        _isRunningTimer = true;
                      });
                    },
                    icon: const Icon(Icons.play_circle),
                  ),
            IconButton(
              onPressed: () {
                // _streamDuration.add(const Duration(minutes: 10));
                _streamDuration.resume();
                setState(() {
                  _isRunningTimer = true;
                });
              },
              icon: const Icon(Icons.restart_alt),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('29:59'),
              ),
            ),
            IconButton(
              onPressed: () {
                print('alarm');
              },
              icon: const Icon(Icons.notifications),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }

  AppBar buildAlarmAppBar() {
    return AppBar(
      title: const Text('Task Notice'),
      actions: [
        TextButton.icon(
          onPressed: () {
            setState(() {
              _turnOnAlarm = !_turnOnAlarm;
            });
          },
          icon: Icon(
            _turnOnAlarm ? Icons.notifications : Icons.notifications_off,
            color: _turnOnAlarm ? Colors.teal : Colors.red,
          ),
          label: const Text(''),
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
