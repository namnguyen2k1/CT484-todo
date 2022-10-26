import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(1),
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
              children: buildStarRank(3),
            ),
            const SizedBox(
              height: 5,
            ),
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
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    setState(() {
                      _completed = !_completed;
                    });
                  },
                  icon: Icon(
                      _completed ? Icons.check_circle : Icons.circle_outlined),
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
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'Học lập trình Flutter là một trãi nghiệm rất là thú vị. Học ngay đi nào! '),
                                WidgetSpan(
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
                          )),
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

  List<Widget> buildStarRank(int starCount) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < starCount; i++) {
      list.add(const Icon(Icons.star));
      list.add(const SizedBox(width: 5));
    }

    return list;
  }
}
