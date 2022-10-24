import 'package:flutter/material.dart';

class ScaffoldMessengerCustom {
  const ScaffoldMessengerCustom({Key? key});

  static showSuccessMessage(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // backgroundColor: Colors.teal,
      duration: const Duration(milliseconds: 500),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.alarm),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                // color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      shape: const StadiumBorder(), // border max
    ));
  }
}
