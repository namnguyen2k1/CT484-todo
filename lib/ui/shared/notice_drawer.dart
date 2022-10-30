import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AlarmDrawer extends StatefulWidget {
  const AlarmDrawer({super.key});

  @override
  State<AlarmDrawer> createState() => _AlarmDrawerState();
}

class _AlarmDrawerState extends State<AlarmDrawer> {
  final _promodoroTimeOptions = [
    '25 phút',
    '30 phút',
    '35 phút',
    '40 phút',
    '45 phút'
  ];
  final _shortBreakTimeOptions = ['3 phút', '5 phút', '8 phút', '10 phút'];
  final _longBreakTimeOptions = ['10 phút', '15 phút', '20 phút'];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    const double settingOptionPadding = 10.0;
    return Drawer(
      width: deviceSize.width,
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Notification Settings'),
            automaticallyImplyLeading: false,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: settingOptionPadding,
              right: settingOptionPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text('Promodoro'),
                    ),
                    const Text('25 Phut'),
                  ],
                ),
                ToggleSwitch(
                  minWidth: 100,
                  initialLabelIndex: 0,
                  fontSize: 16.0,
                  totalSwitches: _promodoroTimeOptions.length,
                  labels: _promodoroTimeOptions,
                  onToggle: (index) {
                    final String selectedItem =
                        _promodoroTimeOptions[index!].toString();
                    print(selectedItem);
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: settingOptionPadding,
              right: settingOptionPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text('Short BreakTime'),
                    ),
                    const Text('5 Phut'),
                  ],
                ),
                ToggleSwitch(
                  minWidth: 100,
                  initialLabelIndex: 0,
                  fontSize: 16.0,
                  totalSwitches: _shortBreakTimeOptions.length,
                  labels: _shortBreakTimeOptions,
                  onToggle: (index) {
                    final String selectedItem =
                        _shortBreakTimeOptions[index!].toString();
                    print(selectedItem);
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: settingOptionPadding,
              right: settingOptionPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text('Long BreakTime'),
                    ),
                    const Text('10 Phut'),
                  ],
                ),
                ToggleSwitch(
                  minWidth: 100,
                  initialLabelIndex: 0,
                  fontSize: 16.0,
                  totalSwitches: _longBreakTimeOptions.length,
                  labels: _longBreakTimeOptions,
                  onToggle: (index) {
                    final String selectedItem =
                        _longBreakTimeOptions[index!].toString();
                    print(selectedItem);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
