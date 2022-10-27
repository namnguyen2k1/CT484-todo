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

Future<void> showAlearDialog(
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
