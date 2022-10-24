import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(
    BuildContext context, String answer, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        answer,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(ctx).pop(true);
          },
        ),
      ],
    ),
  );
}

Future<void> showInformation(
  BuildContext context,
  String title,
  String description,
) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        description,
        style: const TextStyle(
          fontSize: 10,
          fontStyle: FontStyle.italic,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Argee'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}


/**
 * 
DefaultTabController(
            length: 3, // length of tabs
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  // color: Colors.yellow[50],
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
                  height: 400, //height of TabBarView
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
                        children: [
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
                        children: [
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
                        children: [
                          Card(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              leading: Icon(
                                Icons.group_sharp,
                                size: _flutterIconSize,
                              ),
                              title: Text('Three-line ListTile'),
                              subtitle: const Text(
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
 */