import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:todoapp/ui/modules/utilities/format_time.dart';

import 'package:todoapp/ui/shared/custom_dialog.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import '../../shared/risk_text.dart';
import '../../../state/models/task_model.dart';

class TaskItem extends StatefulWidget {
  final TaskModel? item;

  const TaskItem({
    super.key,
    this.item,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  String _id = '';
  String _categoryId = '';
  String _name = '';
  int _star = 1;
  String _color = '';
  String _description = '';
  String _imageUrl = FakeData.icons[0]['path'];
  String _createdAt = '';
  String _workingTime = '';
  bool _isCompleted = false;

  @override
  void initState() {
    final item = widget.item;
    if (item != null) {
      _id = item.id;
      _categoryId = item.categoryId;
      _name = item.name;
      _star = item.star;
      _color = item.color;
      _description = item.description;
      _imageUrl = item.imageUrl;
      _createdAt = item.createdAt;
      _workingTime = item.workingTime;
      _isCompleted = item.isCompleted;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse(_color)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          buildTaskHeader(deviceSize, context),
          const SizedBox(
            height: 5,
          ),
          buildTaskBody(context),
        ],
      ),
    );
  }

  Container buildTaskHeader(Size deviceSize, BuildContext context) {
    final categoryController = context.read<CategoryController>();
    final taskController = context.read<TaskController>();
    final category = categoryController.findById(_categoryId);
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
              _name,
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
              RateStar(starCount: _star),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () async {
                  final bool? finshed = await CustomDialog.showConfirm(
                    context,
                    _isCompleted
                        ? 'Bỏ đánh dấu hoàn thành công việc?'
                        : 'Đánh dấu hoàn thành công việc?',
                    DateTime.now().toString(),
                  );
                  if (finshed!) {
                    setState(() {
                      _isCompleted = !_isCompleted;
                    });
                  }
                  if (widget.item != null) {
                    await taskController.updateItem(
                      TaskModel(
                        id: _id,
                        categoryId: _categoryId,
                        name: _name,
                        star: _star,
                        color: _color,
                        description: _description,
                        imageUrl: _imageUrl,
                        createdAt: _createdAt,
                        workingTime: _workingTime,
                        isCompleted: _isCompleted,
                      ),
                    );
                  }
                },
                icon: Icon(
                  _isCompleted ? Icons.check_circle : Icons.circle_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildTaskBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Image.asset(
            _imageUrl,
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
                          color: Color(int.parse(_color)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          FormatTime.converSecondsToText(
                              int.parse(_workingTime)),
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
                          FormatTime.convertTimestampToFormatTimer(_createdAt),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.query_builder,
                          color: Color(int.parse(_color)),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                RiskTextCustom(
                  content: _description,
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



/// Dismissible
// key: const ValueKey(1),
// background: Container(
//   color: Theme.of(context).errorColor,
//   alignment: Alignment.centerRight,
//   padding: const EdgeInsets.only(right: 20),
//   margin: const EdgeInsets.symmetric(
//     horizontal: 15,
//     vertical: 4,
//   ),
//   child: const Icon(
//     Icons.delete,
//     color: Colors.white,
//     size: 40,
//   ),
// ),
// direction: DismissDirection.endToStart,
// confirmDismiss: (direction) {
//   return showConfirmDialog(
//     context,
//     'Do you want to remove the item from the cart?',
//     "Hanh dong sẽ chuyển sang task tiếp theo",
//   );
// },
// onDismissed: (direction) {
//   // context.read<CartManager>().removeItem(productId);
// },
///
