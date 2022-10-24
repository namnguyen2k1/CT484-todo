import 'package:flutter/material.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';

import '../../shared/response_message.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _checkSeenNotification = true;

  @override
  Widget build(BuildContext context) {
    const double _flutterIconSize = 30.0;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: ClipPath(
                    clipper: const ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(
                        border: Border(
                            // bottom: BorderSide(color: Colors.green, width: 3),
                            ),
                      ),
                      child: ListTile(
                        // contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Task Pedding...',
                          style: TextStyle(
                            // color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          _checkSeenNotification
                              ? Icons.access_alarm
                              : Icons.alarm_off_outlined,
                          color: _checkSeenNotification
                              ? Colors.green
                              : Colors.grey,
                        ),
                        onTap: (() {
                          setState(() {
                            _checkSeenNotification = !_checkSeenNotification;
                          });
                        }),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: const Text(
                    'Đang diễn ra',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.book,
                      size: 40,
                    ),
                    title: const Text('Learn NodeJs'),
                    subtitle: const Text('Kiểm tra kiến thức lập trình NodeJs'),
                    trailing: const Icon(Icons.check_circle_outline),
                    onTap: () {
                      showConfirmDialog(
                        context,
                        'Đánh dấu hoành thành công việc?',
                        'Chuyển sang việc tiếp theo',
                      );
                    },
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Card(
                  // color: Colors.black87,
                  margin: const EdgeInsets.only(top: 10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: ClipPath(
                    clipper: const ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      decoration: const BoxDecoration(
                        border: Border(
                            // bottom: BorderSide(color: Colors.green, width: 3),
                            ),
                      ),
                      child: ListTile(
                        // contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Next Task On Day',
                          style: TextStyle(
                            // color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.circle_outlined,
                        ),
                        onTap: () {
                          showConfirmDialog(
                            context,
                            'Đánh dấu hoành thành công việc?',
                            'Chuyển sang việc tiếp theo',
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: const Text(
                    'Sắp đến',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.book,
                      size: 40,
                    ),
                    title: const Text('Learn Flutter'),
                    subtitle: const Text('Học Fluter trong 1 tuần'),
                    trailing: const Icon(Icons.info),
                    onTap: () {
                      showInformation(
                        context,
                        'Learn Flutter',
                        'Flutter là một nền tảng đáng để học hỏi...',
                      );
                    },
                  ),
                ),
                const Divider(),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.book,
                      size: 40,
                    ),
                    title: const Text('Learn Flutter'),
                    subtitle: const Text('Học Fluter trong 1 tuần'),
                    trailing: const Icon(Icons.info),
                    onTap: () {
                      showInformation(
                        context,
                        'Học Flutter',
                        'Flutter là một nền tảng đáng để học hỏi...',
                      );
                    },
                  ),
                ),
                const Divider(),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.book,
                      size: 40,
                    ),
                    title: const Text('Learn Flutter'),
                    subtitle: const Text('Học Fluter trong 1 tuần'),
                    trailing: const Icon(Icons.info),
                    onTap: () {
                      showInformation(
                        context,
                        'Learn Flutter',
                        'Flutter là một nền tảng đáng để học hỏi...',
                      );
                    },
                  ),
                ),
                const Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
