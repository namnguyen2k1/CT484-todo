import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:todoapp/ui/shared/app_drawer.dart';
import '../../../state/controllers/auth_controller.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: const Text('Nam\'s Profile'),
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
          Container(
            height: 200,
            padding: const EdgeInsets.all(10),
            child: const Card(
              color: Colors.teal,
              child: Text('Avatar'),
            ),
          ),
          const Divider(),
          Container(
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
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..pushReplacementNamed('/');
              context.read<AuthController>().logout();
            },
          ),
        ],
      ),
    );
  }
}
