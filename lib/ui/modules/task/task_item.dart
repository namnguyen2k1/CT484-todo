import 'package:flutter/material.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';

class TaskItem extends StatefulWidget {
  final String content;

  const TaskItem({super.key, required this.content});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
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
          color: Colors.deepPurple,
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child: const Text(
                    'Learn Flutter',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: buildStarRank(3),
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
                        child: buildTodoDescription(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.timer),
                          SizedBox(
                            width: 10,
                          ),
                          Text('10:00 AM -> 17:00 PM'),
                        ],
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

  RichText buildTodoDescription() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.content,
          ),
          const WidgetSpan(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.0,
              ),
              child: Icon(
                Icons.edit,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildStarRank(int starCount) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < starCount; i++) {
      list.add(const Icon(Icons.star));
      list.add(const SizedBox(width: 5));
    }

    return list;
  }
}
