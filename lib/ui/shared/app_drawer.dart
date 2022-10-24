import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../state/controllers/auth_controller.dart';
import './dialog_utils.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const double settingOptionPadding = 10.0;
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('App Settings'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.only(
              left: settingOptionPadding,
              right: settingOptionPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.dark_mode),
                ToggleSwitch(
                  initialLabelIndex: 0,
                  fontSize: 16.0,
                  cornerRadius: 10.0,
                  totalSwitches: 3,
                  labels: const ['dark', 'light', 'system'],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.only(
              left: settingOptionPadding,
              right: settingOptionPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.language),
                ToggleSwitch(
                  initialLabelIndex: 0,
                  fontSize: 16.0,
                  cornerRadius: 10.0,
                  totalSwitches: 2,
                  labels: const ['english', 'vietnamese'],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.only(
              left: settingOptionPadding,
              right: settingOptionPadding,
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                showConfirmDialog(
                  context,
                  'Lưu thay đổi?',
                  'Các thay đổi sẽ không thể phục hồi',
                );
              },
              label: Text('Lưu'),
              icon: Icon(Icons.save),
            ),
          ),
        ],
      ),
    );
  }
}
