import 'package:flutter/material.dart';

class RiskTextCustom extends StatelessWidget {
  final String content;
  final IconData lastIcon;

  const RiskTextCustom({
    super.key,
    required this.content,
    required this.lastIcon,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: content,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 2.0,
              ),
              child: Icon(
                lastIcon,
                size: 15,
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


    // const text2 = Text.rich(
    //   TextSpan(
    //     children: [
    //       TextSpan(
    //         text: "Hello, ",
    //       ),
    //       TextSpan(
    //         text: "Nguyen Anh Nam",
    //         style: TextStyle(color: Colors.teal),
    //       ),
    //     ],
    //   ),
    // );