import 'package:flutter/material.dart';

class RateStar extends StatelessWidget {
  final int starCount;

  const RateStar({super.key, required this.starCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buildStarRank(starCount),
    );
  }

  List<Widget> buildStarRank(int starCount) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < starCount; i++) {
      list.add(const Icon(Icons.star));
      list.add(const SizedBox(width: 5));
    }

    return list;
  }
}
