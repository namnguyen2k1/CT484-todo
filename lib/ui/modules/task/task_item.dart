import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/ui/modules/utilities/format_time.dart';
import 'package:todoapp/ui/shared/custom_dialog.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import '../../shared/risk_text.dart';
import '../../../state/models/task_model_change_notifier.dart';

class TaskItem extends StatelessWidget {
  final TaskModel item;

  const TaskItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse(item.color)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(5),
      child: ChangeNotifierProvider.value(
        value: item,
        child: Column(
          children: [
            buildTaskHeader(context, item),
            const SizedBox(
              height: 5,
            ),
            buildTaskBody(context, item),
          ],
        ),
      ),
    );
  }

  Container buildTaskHeader(BuildContext context, TaskModel item) {
    final taskController = context.read<TaskController>();
    final categoryController = context.read<CategoryController>();
    final category = categoryController.findById(item.categoryId);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(int.parse(category.color)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                category.code,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              RateStar(starCount: item.star),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () async {
                  final bool? accepted = await CustomDialog.showConfirm(
                    context,
                    item.isCompleted
                        ? 'Bỏ đánh dấu hoàn thành công việc?'
                        : 'Đánh dấu hoàn thành công việc?',
                    item.isCompleted
                        ? '*Bạn sẽ trở về công việc trước đó'
                        : '*Bạn sẽ chuyển sang công việc tiếp theo',
                  );
                  if (accepted!) {
                    await taskController.updateItem(
                      TaskModel(
                        id: item.id,
                        categoryId: item.categoryId,
                        name: item.name,
                        star: item.star,
                        color: item.color,
                        description: item.description,
                        imageUrl: item.imageUrl,
                        createdAt: item.createdAt,
                        workingTime: item.workingTime,
                        isCompleted: !item.isCompleted,
                      ),
                    );
                  }
                },
                icon: Icon(
                  item.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildTaskBody(BuildContext context, TaskModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
          width: 5,
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
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Color(int.parse(item.color)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          FormatTime.converSecondsToText(
                              int.parse(item.workingTime)),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                      ],
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
                const Divider(),
                RiskTextCustom(
                  content: item.description,
                  lastIcon: Icons.edit,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
