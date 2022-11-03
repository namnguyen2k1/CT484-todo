import 'package:flutter/material.dart';

class SnackBarCustom {
  const SnackBarCustom({Key? key});

  static showSuccessMessage(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(
              Icons.alarm,
              color: Theme.of(context).focusColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        shape: const StadiumBorder(),
      ),
    );
  }
}
