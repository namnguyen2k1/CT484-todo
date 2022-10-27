import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:todoapp/ui/shared/app_drawer.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    const double coverImageHeight = 150;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
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
      ),
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.grey,
                child: Image.asset(
                  'assets/images/coverImage.jpg',
                  width: double.infinity,
                  height: coverImageHeight,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: IconButton(
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
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                  fieldContent: 'Ninh Kieu, Can Tho',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  showConfirmDialog(
                    context,
                    'Xác nhận muốn xoá tài khoản?',
                    '*Lưu ý: hành động không thể phục hồi!',
                  );
                },
                icon: const Icon(Icons.no_accounts),
                label: const Text('Delete Account'),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthController>().logout();
                  print('[logout]');
                },
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildProfileHeader() {
    const double _paddingSize = 2;
    const _textShadow = <Shadow>[
      Shadow(
        // offset: Offset(0.0, 0.0),
        blurRadius: 3.0,
        color: Colors.white,
      ),
    ];

    List<Widget> buildStarRank(int starCount, List<Shadow> _textShadow) {
      List<Widget> list = <Widget>[];
      for (var i = 0; i < starCount; i++) {
        list.add(Icon(
          Icons.star,
          shadows: _textShadow,
        ));
        list.add(const SizedBox(
          width: _paddingSize,
        ));
      }

      return list;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/avatar.gif'),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            const Text(
              'Nguyen Anh Nam',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                shadows: _textShadow,
              ),
            ),
            const SizedBox(
              width: _paddingSize * 4,
            ),
            Row(
              children: buildStarRank(3, _textShadow),
            ),
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
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(fieldTitle), Text(fieldContent)],
          )
        ],
      ),
    );
  }
}

class buildGraphActivity extends StatelessWidget {
  const buildGraphActivity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            dataSource: <SalesData>[
              SalesData('Jan', 10),
              SalesData('Feb', 2),
              SalesData('Mar', 6),
              SalesData('Apr', 9),
              SalesData('May', 15)
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          )
        ],
      ),
    );
  }
}
