import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/controllers/category_controller.dart';
import '../../../state/models/category_model.dart';
import '../../shared/custom_dialog.dart';
import '../../shared/empty_box.dart';
import '../category/category_item.dart';
import '../category/edit_category_screen.dart';
import '../utilities/format_time.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({super.key});

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  int _selectedCategory = -1;
  DateTime _selectedDate = DateTime.now();

  List<CategoryModel> _fillterCategoryDaily(List<CategoryModel> categorise) {
    final filterCategorise = categorise
        .where((element) =>
            FormatTime.convertTimestampToFormatTimer(element.createdAt) ==
            FormatTime.convertTimestampToFormatTimer(_selectedDate.toString()))
        .toList();
    return filterCategorise;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final categoryController = context.read<CategoryController>();
    final listCategory = _fillterCategoryDaily(categoryController.allItems);
    for (var item in listCategory) {
      print(item.toString());
    }
    return Column(
      children: [
        buildSelectDate(context),
        Expanded(
          child: listCategory.isNotEmpty
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
              : const EmptyBox(message: 'Chưa có danh mục nào được tạo'),
        ),
      ],
    );
  }

  Container buildSelectDate(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.date_range_rounded,
                color: Theme.of(context).focusColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                FormatTime.formatTimeLocalArea(time: _selectedDate),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.manage_search,
              color: Theme.of(context).focusColor,
            ),
            onPressed: () async {
              final currentDate = DateTime.now();
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: currentDate,
                firstDate: DateTime(currentDate.year - 1),
                lastDate: DateTime(currentDate.year + 1),
              );
              setState(() {
                _selectedDate = selectedDate!;
              });
            },
          ),
        ],
      ),
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