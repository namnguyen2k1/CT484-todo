import 'package:flutter/material.dart';

class RiskTextCustom extends StatelessWidget {
  final String content;
  final IconData lastIcon;
  final bool onlyLine;

  const RiskTextCustom({
    super.key,
    required this.content,
    required this.lastIcon,
    required this.onlyLine,
  });

  @override
  Widget build(BuildContext context) {
    var filterContent = content;
    if (onlyLine) {
      filterContent = content.replaceAll('\n', ' ');
    }
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: filterContent,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
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
