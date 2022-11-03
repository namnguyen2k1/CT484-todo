import 'package:flutter/material.dart';

class CustomDialog {
  static Future<bool?> showConfirm(
      BuildContext context, String answer, String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        titlePadding:
            const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
        contentPadding: const EdgeInsets.all(10),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        title: Text(
          answer,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(
              Icons.dangerous_outlined,
              color: Theme.of(context).focusColor,
            ),
            label: const Text(
              'No',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
          ),
          ElevatedButton.icon(
            icon: Icon(
              Icons.done,
              color: Theme.of(context).focusColor,
            ),
            label: const Text(
              'Yes',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
          ),
        ],
      ),
    );
  }

  static Future<void> showAlert(
    BuildContext context,
    String title,
    String description,
  ) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        titlePadding:
            const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
        contentPadding: const EdgeInsets.all(10),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(
              Icons.check_circle,
              color: Theme.of(context).focusColor,
            ),
            label: const Text(
              'Agree',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  static Dialog showError(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: 300.0,
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Cool',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Awesome',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 50.0)),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Got It!',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
