import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/state/models/category_model_change_notifier.dart';
import '../../shared/risk_text.dart';
import '../utilities/format_time.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.item,
    required this.widthItem,
    required this.isHorizontal,
    required this.onlyLineContent,
  });

  final CategoryModel item;
  final double widthItem;
  final bool isHorizontal;
  final bool onlyLineContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(
        right: isHorizontal ? 10 : 0,
        bottom: isHorizontal ? 0 : 10,
      ),
      width: widthItem,
      decoration: BoxDecoration(
        color: Color(int.parse(item.color)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ChangeNotifierProvider.value(
        value: item,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCategoryLabel(context, item),
            const SizedBox(
              height: 10,
            ),
            buildCategoryBody(context, item),
          ],
        ),
      ),
    );
  }

  Container buildCategoryLabel(BuildContext context, CategoryModel item) {
    final taskController = context.read<TaskController>();
    final tasksOfCategoryType = taskController.findTasksByCategoryId(item.id);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.name,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '(${tasksOfCategoryType.length} việc)',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Row buildCategoryBody(BuildContext context, CategoryModel item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Image.asset(
            item.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 30,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(int.parse(item.color)),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          item.code,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '-- ${FormatTime.convertTimestampToFormatTimer(item.createdAt)} --',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                RiskTextCustom(
                  content: item.description,
                  lastIcon: Icons.edit,
                  onlyLine: onlyLineContent,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
