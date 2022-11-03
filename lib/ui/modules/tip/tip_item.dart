import 'package:flutter/material.dart';
import 'dart:math' as math;

class TipItem extends StatelessWidget {
  const TipItem({super.key, required this.tip});

  final Map<String, dynamic> tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.tips_and_updates,
            color: Color(
              (math.Random().nextDouble() * 0xFFFFFF).toInt(),
            ).withOpacity(1.0),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Có thể bạn đã biết!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(tip['name']),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
