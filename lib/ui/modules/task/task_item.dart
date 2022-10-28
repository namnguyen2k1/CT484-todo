import 'package:flutter/material.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';
import 'package:todoapp/ui/shared/rate_star.dart';

class TaskItem extends StatefulWidget {
  final Map<String, dynamic> item;

  const TaskItem({super.key, required this.item});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Dismissible(
      key: const ValueKey(1),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
          context,
          'Do you want to remove the item from the cart?',
          "Hanh dong sẽ chuyển sang task tiếp theo",
        );
      },
      onDismissed: (direction) {
        // context.read<CartManager>().removeItem(productId);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey, width: 1.0),
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
                    minWidth: deviceSize.width * 0.5,
                    maxWidth: deviceSize.width * 0.5,
                  ),
                  decoration: BoxDecoration(
                    color: Color(int.parse(widget.item['color'])),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    widget.item['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  children: [
                    RateStar(starCount: widget.item['star']),
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
                            _completed = true;
                          });
                        }
                      },
                      icon: Icon(
                        _completed ? Icons.check_circle : Icons.circle_outlined,
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
                    'assets/images/splash_icon.png',
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
                        children: const [
                          Icon(Icons.timer),
                          SizedBox(
                            width: 10,
                          ),
                          Text('10:00 AM -> 17:00 PM'),
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
                        child: buildTodoDescription(
                          content: widget.item['description'],
                          icon: Icons.edit,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  RichText buildTodoDescription({
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