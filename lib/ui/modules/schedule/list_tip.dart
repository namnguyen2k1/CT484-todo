import 'package:flutter/material.dart';
import '../utilities/fake_data.dart';
import '../tip/tip_item.dart';

class ListTipScreen extends StatelessWidget {
  const ListTipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listItem = FakeData.tips;

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: listItem.length,
      itemBuilder: (context, index) {
        return TipItem(tip: listItem[index]);
      },
    );
  }
}
