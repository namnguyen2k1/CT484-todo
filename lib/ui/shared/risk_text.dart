import 'package:flutter/material.dart';

class RiskTextCustomt extends StatelessWidget {
  final String content;
  final IconData lastIcon;

  const RiskTextCustomt({
    super.key,
    required this.content,
    required this.lastIcon,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: content,
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 2.0,
              ),
              child: Icon(
                lastIcon,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
