import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/ui/shared/custom_dialog.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import '../../../state/controllers/app_settings_controller.dart';
import '../../../state/controllers/auth_controller.dart';
import '../../../state/controllers/task_controller.dart';
import './profile_information.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _starCountFollowingTaskCompleted() {
    final tasks = context.watch<TaskController>().allItems;
    var completedTask = 0;
    for (var element in tasks) {
      if (element.isCompleted == true) completedTask++;
    }
    if (completedTask >= 50) return 3;
    if (completedTask >= 10) return 2;
    return 1;
  }

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
    const double coverImageHeight = 150;
    const double avatarSize = 150;
    final appSettingController =
        Provider.of<AppSettingsController>(context, listen: true);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Image.asset(
                  appSettingController.coverImageUrl,
                  width: double.infinity,
                  height: coverImageHeight,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: coverImageHeight - avatarSize / 2,
                left: 20,
                child: buildProfileHeader(avatarSize: avatarSize),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: buildPupupMenu(context),
              ),
            ],
          ),
          const SizedBox(
            height: avatarSize / 2,
          ),
          buildProfileInformations(),
          buildProfileControls(context),
          const SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }

  Container buildPupupMenu(BuildContext context) {
    final listCoverImage = FakeData.coverImages;

    final appSettingController = context.watch<AppSettingsController>();
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: PopupMenuButton(
        onSelected: (setectedValue) {
          setState(
            () async {
              await appSettingController.changeCoverImage(
                imageUrl: setectedValue.toString(),
              );
            },
          );
        },
        icon: const Icon(
          Icons.collections,
          size: 15,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: listCoverImage[0]['path'],
            child: const Text('Ảnh Bìa 1'),
          ),
          PopupMenuItem(
            value: listCoverImage[1]['path'],
            child: const Text('Ảnh Bìa 2'),
          ),
          PopupMenuItem(
            value: listCoverImage[2]['path'],
            child: const Text('Ảnh Bìa 3'),
          ),
        ],
      ),
    );
  }

  Row buildProfileHeader({required double avatarSize}) {
    const double paddingSize = 2;

    final account = context.watch<AuthController>().authToken;
    final emailHeader = account!.email.split('@')[0];
    final username =
        "${emailHeader[0].toUpperCase()}${emailHeader.substring(1).toLowerCase()}";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        WidgetCircularAnimator(
          size: avatarSize,
          innerAnimation: Curves.bounceOut,
          outerAnimation: Curves.ease,
          innerColor: Colors.deepOrange,
          outerColor: Colors.teal,
          child: Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/avatar.gif'),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: Theme.of(context).focusColor,
                width: 1.0,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              const SizedBox(
                width: paddingSize * 4,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).focusColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  username,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                  ),
                ),
              ),
              RateStar(starCount: _starCountFollowingTaskCompleted()),
            ],
          ),
        ),
      ],
    );
  }

  Container buildProfileInformations() {
    final account = context.watch<AuthController>().authToken;
    final tasks = context.watch<TaskController>().allItems;
    final easy = tasks.where((element) => element.star == 1).toList().length;
    final medium = tasks.where((element) => element.star == 2).toList().length;
    final hard = tasks.where((element) => element.star == 3).toList().length;
    final tasksDone =
        tasks.where((element) => element.isCompleted == true).toList().length;
    final categories = context.watch<CategoryController>().allItems;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          BuildTextInformation(
            icon: Icons.email,
            fieldTitle: 'Địa chỉ email',
            fieldContent: account!.email,
          ),
          const Divider(),
          BuildTextInformation(
            icon: Icons.view_comfortable,
            fieldTitle: 'Tổng quan danh mục',
            fieldContent: '${categories.length} danh mục',
          ),
          const Divider(),
          BuildTextInformation(
            icon: Icons.task,
            fieldTitle: 'Tổng quan công việc',
            fieldContent: '$easy dễ, $medium trung bình, $hard khó',
          ),
          const Divider(),
          BuildFinishedTask(
            icon: Icons.task_alt,
            fieldTitle: 'Tiến độ làm việc',
            fieldContent: 'Đã hoàn thành $tasksDone việc',
          ),
        ],
      ),
    );
  }

  Container buildProfileControls(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSwitchThemeButton(),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Xoá tài khoản cục bộ',
                  style: TextStyle(color: Colors.red),
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      CustomDialog.showConfirm(
                        context,
                        'Xác nhận muốn xoá tài khoản?',
                        '*không thể phục hồi tài khoản',
                      );
                    },
                    icon: const Icon(
                      Icons.no_accounts,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Đăng xuất',
                  style: TextStyle(color: Colors.teal),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    context.read<AuthController>().logout();
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.teal,
                  ),
                )
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Container buildSwitchThemeButton() {
    const double settingOptionPadding = 10.0;
    final themeOptions = ['dark', 'light'];
    final themeOptionsVietsub = ['Tối', 'Sáng'];
    final appSettingsController = context.watch<AppSettingsController>();
    return Container(
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
            initialLabelIndex: themeOptions.indexOf(
              appSettingsController.isDarkTheme ? 'dark' : 'light',
            ),
            minHeight: 30,
            activeBgColor: [Theme.of(context).focusColor],
            borderWidth: 1.0,
            inactiveFgColor: Colors.black,
            fontSize: 16.0,
            totalSwitches: themeOptions.length,
            labels: themeOptionsVietsub,
            onToggle: (index) {
              final String selectedTheme = themeOptions[index!].toString();
              appSettingsController.changeAppTheme(
                theme: selectedTheme,
              );
            },
          ),
        ],
      ),
    );
  }
}
