import 'package:flutter/material.dart';

class TopRightBadge extends StatelessWidget {
  const TopRightBadge({
    super.key,
    required this.child,
    required this.data,
    this.color,
  });

  final Widget child;
  final Object data;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    const double sizeBox = 20;
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          left: 30,
          bottom: 25,
          child: Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).focusColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(5),
              color: color ?? Theme.of(context).backgroundColor,
            ),
            constraints: const BoxConstraints(
              minWidth: sizeBox,
              minHeight: sizeBox,
            ),
            child: Text(
              data.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).focusColor,
                fontSize: 15,
              ),
            ),
          ),
        )
      ],
    );
  }
}
