import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/state/models/category_model.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:uuid/uuid.dart';

import '../../shared/risk_text.dart';
import '../utilities/format_time.dart';

class CategoryItem extends StatefulWidget {
  CategoryItem(
    CategoryModel? item, {
    super.key,
    required this.widthItem,
    required this.isHorizontal,
  }) {
    if (item != null) {
      this.item = item;
    } else {
      this.item = CategoryModel(
        id: const Uuid().v4(),
        code: '',
        name: '',
        description: '',
        imageUrl: FakeData.icons[0]['path'],
        color: Colors.deepOrange.value.toString(),
        createdAt: DateTime.now().toString(),
      );
    }
  }

  late CategoryModel? item;
  late double widthItem;
  late bool isHorizontal;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  String _id = '';
  String _code = '';
  String _name = '';
  String _description = '';
  String _imageUrl = '';
  String _color = '';
  String _createdAt = '';

  @override
  void initState() {
    final item = widget.item;
    if (item != null) {
      _id = item.id;
      _code = item.code;
      _name = item.name;
      _description = item.description;
      _imageUrl = item.imageUrl;
      _color = item.color;
      _createdAt = item.createdAt;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(
        right: widget.isHorizontal ? 10 : 0,
        bottom: widget.isHorizontal ? 0 : 10,
      ),
      width: widget.widthItem,
      decoration: BoxDecoration(
        color: Color(int.parse(_color)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCategoryLabel(context, _name, _color),
          const SizedBox(
            height: 10,
          ),
          buildCategoryBody(context),
        ],
      ),
    );
  }

  Container buildCategoryLabel(
      BuildContext context, String name, String color) {
    final taskController = context.read<TaskController>();
    final tasksOfCategoryType = taskController.findTasksByCategoryId(_id);
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
            name,
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

  Row buildCategoryBody(BuildContext context) {
    return Row(
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
                      width: 40,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(int.parse(_color)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _code,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '-- ${FormatTime.convertTimestampToFormatTimer(_createdAt)} --',
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
                  content: _description,
                  lastIcon: Icons.edit,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
