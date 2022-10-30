import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/ui/shared/app_settings_drawer.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import '../../../state/controllers/auth_controller.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldAppSettingsKey =
      GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldAppSettingsKey.currentState!.openDrawer();
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
    const double coverImageHeight = 200;
    return Scaffold(
      key: _scaffoldAppSettingsKey,
      drawer: const AppDrawer(),
      // drawerEnableOpenDragGesture: false,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: 'Setting',
                  onPressed: _openDrawer,
                ),
              ],
              title: const Text("Profile Overview"),
              expandedHeight: 0,
              floating: false,
              snap: false,
              pinned: false,
            )
          ];
        },
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.grey,
                  child: Image.asset(
                    'assets/images/cover_image_2.jpg',
                    width: double.infinity,
                    height: coverImageHeight,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        Navigator.pushNamed(context, '/workspace/profile/edit');
                      },
                      icon: const Icon(
                        Icons.build,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: buildProfileHeader(),
                )
              ],
            ),
            buildProfileInformations(),
            buildProfileStatistical(),
            Center(
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 10.0,
                percent: 0.9,
                center: const Center(child: RateStar(starCount: 2)),
                backgroundColor: Colors.red,
                progressColor: Colors.green,
                footer: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Finished more than 19 task to upgrade rank',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Divider(),
            buildProfileControls(context),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildProfileAppBar() {
    return AppBar(
      title: const Text('Profile Overview'),
      // leadingWidth: 0,
      // titleSpacing: 0,
      automaticallyImplyLeading: false,
      // backgroundColor: Colors.black87,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Setting',
          onPressed: _openDrawer,
        ),
      ],
    );
  }

  Column buildProfileControls(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    showConfirmDialog(
                      context,
                      'Xác nhận muốn xoá tài khoản?',
                      '*Lưu ý: hành động không thể phục hồi!',
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Logout',
                style: TextStyle(color: Colors.teal),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    context.read<AuthController>().logout();
                    print('[logout]');
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.teal,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Container buildProfileInformations() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: const [
          buildTextInformation(
            icon: Icons.email,
            fieldTitle: 'Email',
            fieldContent: 'nanam133hg@gmail.com',
          ),
          Divider(),
          buildTextInformation(
            icon: Icons.home,
            fieldTitle: 'Address',
            fieldContent: 'Đại học Cần Thơ, Ninh Kiều Cần Thơ',
          ),
        ],
      ),
    );
  }

  Container buildProfileStatistical() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: const [
          buildTextInformation(
            icon: Icons.task,
            fieldTitle: 'Task',
            fieldContent: '103 easy, 56 middle, 19 hard',
          ),
          Divider(),
          buildTextInformation(
            icon: Icons.category,
            fieldTitle: 'Category',
            fieldContent: '9 category',
          ),
        ],
      ),
    );
  }

  Row buildProfileHeader() {
    const double paddingSize = 2;
    const textShadow = <Shadow>[
      Shadow(
        // offset: Offset(0.0, 0.0),
        blurRadius: 3.0,
        color: Colors.white,
      ),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const WidgetCircularAnimator(
          size: 100,
          innerAnimation: Curves.bounceOut,
          outerAnimation: Curves.ease,
          innerColor: Colors.teal,
          outerColor: Colors.purpleAccent,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/avatar.gif'),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: const [
            Text(
              'Nguyen Anh Nam',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                shadows: textShadow,
              ),
            ),
            SizedBox(
              width: paddingSize * 4,
            ),
            RateStar(starCount: 3),
          ],
        ),
      ],
    );
  }
}

class buildTextInformation extends StatelessWidget {
  final IconData? icon;
  final String fieldTitle;
  final String fieldContent;
  const buildTextInformation({
    Key? key,
    required this.icon,
    required this.fieldTitle,
    required this.fieldContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$fieldTitle:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(fieldContent)
            ],
          )
        ],
      ),
    );
  }
}
