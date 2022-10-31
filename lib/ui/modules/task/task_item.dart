import 'package:flutter/material.dart';

import 'package:todoapp/ui/shared/dialog_utils.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import '../../shared/risk_text.dart';
import '../../../state/models/task_model.dart';

class TaskItem extends StatefulWidget {
  final TaskModel? item;
  final bool focus;

  const TaskItem({super.key, this.item, required this.focus});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  String _id = '-1';
  String _categoryId = '-1';
  String _name = 'default task name';
  int _star = 1;
  String _color = '4294940672';
  String _description = 'default description';
  String _imageUrl = 'assets/images/splash_icon.png';
  String _startTime = '31/10/2022';
  String _finishTime = '1/11/2022';
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
      _startTime = item.startTime;
      _finishTime = item.finishTime;
      _isCompleted = item.isCompleted;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: widget.focus
            ? Border.all(color: Colors.green, width: 2.0)
            : Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: BoxConstraints(
                  minWidth: deviceSize.width * 0.4,
                  maxWidth: deviceSize.width * 0.4,
                ),
                decoration: BoxDecoration(
                  color: Color(int.parse(_color)),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  _name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
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
                      final bool? finshed = await showConfirmDialog(
                        context,
                        'Đánh dấu hoành thành công việc?',
                        DateTime.now().toString(),
                      );
                      if (finshed!) {
                        setState(() {
                          _isCompleted = true;
                        });
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
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: Image.asset(
                  _imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$_startTime AM -> $_finishTime PM',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: RiskTextCustomt(
                        content: _description,
                        lastIcon: Icons.edit,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
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
