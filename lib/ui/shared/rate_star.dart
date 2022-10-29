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
    Color colorStar = Colors.blue;
    switch (starCount) {
      case 2:
        colorStar = Colors.green;
        break;
      case 3:
        colorStar = Colors.deepOrange;
        break;
      default:
    }

    List<Widget> list = <Widget>[];
    for (var i = 0; i < starCount; i++) {
      list.add(Icon(
        Icons.star,
        color: colorStar,
      ));
      list.add(const SizedBox(width: 5));
    }

    return list;
  }
}
