import 'package:flutter/material.dart';

class CustomSnackBar {
  const CustomSnackBar({Key? key});

  static showQuickMessage(BuildContext context, String message) {
    final deviceSize = MediaQuery.of(context).size;
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).focusColor,
        margin: EdgeInsets.only(
          bottom: deviceSize.height - 200,
          right: 10,
          left: 10,
        ),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(
              Icons.alarm,
              color: Theme.of(context).backgroundColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        shape: const StadiumBorder(),
      ),
    );
  }

  static showTopBannder(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        leading: const Icon(Icons.notifications_active_outlined),
        elevation: 5,
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        content: Text(message),
        actions: [
          ElevatedButton.icon(
            icon: Icon(
              Icons.check_circle,
              color: Theme.of(context).focusColor,
            ),
            label: const Text(
              'Đóng',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
          ),
        ],
      ),
    );
  }
}
