import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/controllers/category_controller.dart';
import '../../../state/models/category_model.dart';
import '../../shared/custom_dialog.dart';
import '../../shared/empty_box.dart';
import '../category/category_item.dart';
import '../category/edit_category_screen.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({super.key});

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  int _selectedCategory = -1;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Consumer<CategoryController>(
      builder: (context, categoryController, child) {
        final listCategory = categoryController.allItems;
        print('local task');
        for (var item in listCategory) {
          print(item.toString());
        }
        return listCategory.isNotEmpty
            ? ListView.builder(
                itemCount: listCategory.length,
                itemBuilder: (BuildContext context, int index) {
                  final bool isMatch = _selectedCategory == index;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedCategory = index;
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).backgroundColor,
                          padding: EdgeInsets.zero,
                        ),
                        child: CategoryItem(
                          listCategory[index],
                          widthItem: isMatch
                              ? deviceSize.width * 0.85
                              : deviceSize.width - 20,
                          isHorizontal: false,
                        ),
                      ),
                      isMatch
                          ? buildCategoryControlButton(
                              context,
                              listCategory,
                              index,
                            )
                          : const SizedBox(
                              width: 0,
                            ),
                    ],
                  );
                },
                padding: const EdgeInsets.all(10),
              )
            : const EmptyBox(message: 'No Category');
      },
    );
  }

  Row buildCategoryControlButton(
    BuildContext context,
    List<CategoryModel> listCategory,
    int index,
  ) {
    final categoryController = context.read<CategoryController>();
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditCategoryScreen(
                      listCategory[index],
                    ),
                  ),
                );
                // re-build category
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                final bool? isAccept = await CustomDialog.showConfirm(
                  context,
                  'Bạn muốn xoá công việc này?',
                  '*không thể phục hồi công việc đã xoá',
                );
                if (isAccept != false) {
                  print('delete task');
                  await categoryController.deleteItem(
                    listCategory[index].id,
                  );
                }
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
