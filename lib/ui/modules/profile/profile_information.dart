import 'package:flutter/material.dart';

import '../../shared/rate_star.dart';

class BuildTextInformation extends StatelessWidget {
  final IconData? icon;
  final String fieldTitle;
  final String fieldContent;
  const BuildTextInformation({
    Key? key,
    required this.icon,
    required this.fieldTitle,
    required this.fieldContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$fieldTitle:',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                fieldContent,
                style: TextStyle(
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BuildFinishedTask extends StatelessWidget {
  final IconData? icon;
  final String fieldTitle;
  final String fieldContent;
  const BuildFinishedTask({
    Key? key,
    required this.icon,
    required this.fieldTitle,
    required this.fieldContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$fieldTitle:',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  fieldContent,
                  style: TextStyle(
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).focusColor, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [
                          RateStar(starCount: 1),
                          SizedBox(
                            height: 5,
                          ),
                          Text('1 việc'),
                        ],
                      ),
                      const Icon(Icons.arrow_forward),
                      Column(
                        children: const [
                          RateStar(starCount: 2),
                          SizedBox(
                            height: 5,
                          ),
                          Text('10 việc'),
                        ],
                      ),
                      const Icon(Icons.arrow_forward),
                      Column(
                        children: const [
                          RateStar(starCount: 3),
                          SizedBox(
                            height: 5,
                          ),
                          Text('50 việc'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
