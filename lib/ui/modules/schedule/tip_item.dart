import 'package:flutter/material.dart';

class TipItem extends StatelessWidget {
  const TipItem({super.key, required this.tip, required this.colorTip});

  final Color colorTip;
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
            color: colorTip,
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
                    border: Border.all(
                        color: Theme.of(context).focusColor, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tip['name'],
                    style: TextStyle(
                      color: Theme.of(context)
                          .floatingActionButtonTheme
                          .backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
