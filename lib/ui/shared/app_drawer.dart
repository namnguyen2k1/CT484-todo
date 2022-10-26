import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/app_settings_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../state/controllers/auth_controller.dart';
import './dialog_utils.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _themeOptions = ['dark', 'light'];
  final _languageOptions = ['vi', 'eng'];

  @override
  Widget build(BuildContext context) {
    const double settingOptionPadding = 10.0;
    final appSettingsController = Provider.of<AppSettingsController>(context);
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
                Icon(
                  appSettingsController.isDarkTheme
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                ToggleSwitch(
                  initialLabelIndex: _themeOptions.indexOf(
                    appSettingsController.isDarkTheme ? 'dark' : 'light',
                  ),
                  fontSize: 16.0,
                  cornerRadius: 10.0,
                  totalSwitches: 2,
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
          const Divider(),
          Container(
            padding: const EdgeInsets.only(
              left: settingOptionPadding,
              right: settingOptionPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appSettingsController.isEnglishLanguage
                    ? const Text('English')
                    : const Text('Vietnamese'),
                ToggleSwitch(
                  initialLabelIndex: _languageOptions.indexOf(
                    appSettingsController.isEnglishLanguage ? 'eng' : 'vi',
                  ),
                  fontSize: 16.0,
                  cornerRadius: 10.0,
                  totalSwitches: 2,
                  labels: _languageOptions,
                  onToggle: (index) {
                    final String selectedLanguage =
                        _languageOptions[index!].toString();
                    appSettingsController.changeAppLanguage(
                      language: selectedLanguage,
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
