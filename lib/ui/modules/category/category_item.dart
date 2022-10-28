import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Map<String, dynamic> category;
  final double widthItem;
  const CategoryItem(
      {super.key, required this.category, required this.widthItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(right: 10),
      width: widthItem,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
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
                child: buildCategoryLabel(category),
              ),
            ],
          ),
          const Divider(),
          buildRiskText(content: category['description'], icon: Icons.edit)
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

  RichText buildRiskText({
    required String content,
    required IconData icon,
  }) {
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
                icon,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
