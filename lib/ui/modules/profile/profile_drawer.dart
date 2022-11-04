import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:todoapp/state/controllers/app_settings_controller.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _themeOptions = ['dark', 'light'];

  @override
  Widget build(BuildContext context) {
    const double settingOptionPadding = 10.0;
    final appSettingsController = Provider.of<AppSettingsController>(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Cài đặc'),
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
                Icon(
                  appSettingsController.isDarkTheme
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                ToggleSwitch(
                  initialLabelIndex: _themeOptions.indexOf(
                    appSettingsController.isDarkTheme ? 'dark' : 'light',
                  ),
                  activeFgColor: Theme.of(context).bottomAppBarColor,
                  fontSize: 16.0,
                  totalSwitches: _themeOptions.length,
                  labels: _themeOptions,
                  onToggle: (index) {
                    final String selectedTheme =
                        _themeOptions[index!].toString();
                    appSettingsController.changeAppTheme(
                      theme: selectedTheme,
                    );
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
