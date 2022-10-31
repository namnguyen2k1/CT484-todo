import 'package:flutter/material.dart';
import 'package:todoapp/state/models/category_model.dart';

import '../../shared/risk_text.dart';

class CategoryItem extends StatefulWidget {
  final CategoryModel? item;
  final double widthItem;
  final bool isHorizontal;
  final bool focus;

  const CategoryItem({
    super.key,
    this.item,
    required this.widthItem,
    required this.isHorizontal,
    required this.focus,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  String _id = '-1';
  String _code = 'default';
  String _name = 'default category name';
  String _description = 'default category description';
  String _color = 'default category color';
  String _createdAt = '31/10/2022';

  @override
  void initState() {
    final item = widget.item;
    if (item != null) {
      _id = item.id;
      _code = item.code;
      _name = item.name;
      _description = item.description;
      _color = item.color;
      _createdAt = item.createdAt;
    }
    super.initState();
  }

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
                child: buildCategoryLabel(_name, _color),
              ),
            ],
          ),
          const Divider(),
          RiskTextCustomt(
            content: _description,
            lastIcon: Icons.edit,
          ),
        ],
      ),
    );
  }

  Container buildCategoryLabel(String name, String color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Color(
          int.parse(color),
        ),
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
