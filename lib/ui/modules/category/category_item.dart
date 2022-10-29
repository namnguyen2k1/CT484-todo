import 'package:flutter/material.dart';

import '../../shared/risk_text.dart';

class CategoryItem extends StatefulWidget {
  final Map<String, dynamic> category;
  final double widthItem;
  final bool isHorizontal;
  final bool focus;

  const CategoryItem({
    super.key,
    required this.category,
    required this.widthItem,
    required this.isHorizontal,
    required this.focus,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(
        right: widget.isHorizontal ? 10 : 0,
        bottom: widget.isHorizontal ? 0 : 10,
      ),
      width: widget.widthItem,
      decoration: BoxDecoration(
        border: widget.focus
            ? Border.all(color: Colors.green, width: 2.0)
            : Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  'assets/images/splash_icon.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: buildCategoryLabel(widget.category),
              ),
            ],
          ),
          const Divider(),
          RiskTextCustomt(
            content: widget.category['description'],
            lastIcon: Icons.edit,
          ),
        ],
      ),
    );
  }

  Container buildCategoryLabel(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Color(
          int.parse(item['color']),
        ),
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '${item['title']}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
