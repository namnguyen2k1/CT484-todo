import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  static const routeName = '/schedule';
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    const double _flutterIconSize = 30.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('adding task');
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add_task),
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 50,
              padding: const EdgeInsets.all(5),
              child: const TabBar(
                isScrollable: false,
                // labelColor: Colors.yellow,
                // indicatorColor: Colors.black,
                indicatorWeight: 2,
                // unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  // color: Colors.green,
                ),
                tabs: [
                  Tab(
                    icon: Icon(Icons.admin_panel_settings_sharp),
                  ),
                  Tab(
                    icon: Icon(Icons.school),
                  ),
                  Tab(
                    icon: Icon(Icons.group_sharp),
                  )
                ],
              ),
            ),
            Container(
              height: deviceSize.height - 210, //height of TabBarView
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    // color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              child: TabBarView(
                children: <Widget>[
                  ListView(
                    children: const [
                      Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading: Icon(
                            Icons.admin_panel_settings_sharp,
                            size: _flutterIconSize,
                          ),
                          title: Text('Two-line ListTile'),
                          subtitle: Text('Here is a second line'),
                          trailing: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: const [
                      Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading: Icon(
                            Icons.school,
                            size: _flutterIconSize,
                          ),
                          title: Text('Two-line ListTile'),
                          subtitle: Text('Here is a second line'),
                          trailing: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: const [
                      Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading: Icon(
                            Icons.group_sharp,
                            size: _flutterIconSize,
                          ),
                          title: Text('Three-line ListTile'),
                          subtitle: Text(
                            'A sufficiently long subtitle warrants three lines.',
                          ),
                          trailing: Icon(Icons.delete),
                          isThreeLine: true,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// Container(
//             width: deviceSize.width,
//             height: 100,
//             padding: const EdgeInsets.all(10),
//             child: const Card(
//               color: Colors.teal,
//               child: const Text('Current Task'),
//             ),
//           ),