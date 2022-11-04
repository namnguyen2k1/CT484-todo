import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../utilities/fake_data.dart';
import '../tip/tip_item.dart';

class ListTipScreen extends StatelessWidget {
  const ListTipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listTip = FakeData.tips;
    const int tipRandomCount = 5;
    final listExistedTip = <int>[];
    while (listExistedTip.length < tipRandomCount) {
      final index = math.Random().nextInt(listTip.length);
      if (!listExistedTip.contains(index)) {
        listExistedTip.add(index);
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: listExistedTip.length,
      itemBuilder: (context, index) {
        return TipItem(
          tip: listTip[listExistedTip[index]],
          colorTip: Color(
            (math.Random().nextDouble() * 0xFFFFFF).toInt(),
          ).withOpacity(1.0),
        );
      },
    );
  }
}
