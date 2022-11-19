import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/state/controllers/task_controller.dart';
import 'package:todoapp/ui/modules/category/category_item.dart';
import 'package:todoapp/ui/modules/task/task_item.dart';
import 'package:todoapp/ui/shared/empty_box.dart';

class ScheduleSearchScreen extends StatefulWidget {
  const ScheduleSearchScreen({super.key});

  @override
  State<ScheduleSearchScreen> createState() => _ScheduleSearchScreenState();
}

class _ScheduleSearchScreenState extends State<ScheduleSearchScreen> {
  String _searchKey = '____';
  final _searchFormKey = GlobalKey<FormState>();
  final _searchKeyController = TextEditingController();
  final _searchKeyFocusNode = FocusNode();
  bool _isViewResult = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchKeyController.dispose();
    _searchKeyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tìm Kiếm'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Form(
            key: _searchFormKey,
            child: buildNameField(),
          ),
          buildSearchResults(),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Container buildNameField() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
      child: TextFormField(
        onSaved: (value) {
          _searchKey = value!;
        },
        onFieldSubmitted: (value) {
          if (!_searchFormKey.currentState!.validate()) {
            return;
          }
          _searchFormKey.currentState!.save();
          setState(() {
            _isViewResult = true;
          });
        },
        controller: _searchKeyController,
        focusNode: _searchKeyFocusNode,
        decoration: const InputDecoration(
          hintText: 'công việc, danh mục,..',
          suffixIcon: Icon(Icons.search),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.name,
        autofocus: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Nhập giá trị tìm kiếm!';
          }
          return null;
        },
      ),
    );
  }

  Column buildSearchResults() {
    final tasks = context.watch<TaskController>().allItems;
    final categories = context.watch<CategoryController>().allItems;
    var tasksMatch = tasks.where((e) => e.name.contains(_searchKey)).toList();
    var cartegoriesMatch =
        categories.where((e) => e.name.contains(_searchKey)).toList();
    return Column(
      children: [
        if (tasksMatch.isNotEmpty) ...[
          Container(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
            child: Row(
              children: [
                const Icon(Icons.task),
                const SizedBox(width: 10),
                Text('Công việc (${tasksMatch.length})'),
              ],
            ),
          ),
          Column(
            children: tasksMatch
                .map((e) => Container(
                      padding: const EdgeInsets.all(10),
                      child: TaskItem(
                        item: e,
                      ),
                    ))
                .toList(),
          ),
        ],
        if (cartegoriesMatch.isNotEmpty) ...[
          Container(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
            child: Row(
              children: [
                const Icon(Icons.view_comfortable),
                const SizedBox(width: 10),
                Text('Danh mục (${cartegoriesMatch.length})'),
              ],
            ),
          ),
          Column(
            children: cartegoriesMatch
                .map(
                  (e) => Container(
                    padding: const EdgeInsets.all(10),
                    child: CategoryItem(
                      item: e,
                      isHorizontal: false,
                      widthItem: MediaQuery.of(context).size.width,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
        if (tasksMatch.isEmpty &&
            cartegoriesMatch.isEmpty &&
            _isViewResult) ...[
          Container(
            padding: const EdgeInsets.all(10),
            child: const EmptyBox(message: 'Không tìm thấy kết quả phù hợp!'),
          ),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_left),
              label: const Text('Đóng'),
            ),
            if (_isViewResult) ...[
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _searchKey = '____';
                    _isViewResult = false;
                  });
                  _searchKeyController.text = '';
                  _searchKeyFocusNode.requestFocus();
                },
                icon: const Icon(Icons.refresh_outlined),
                label: const Text('Tìm mới'),
              ),
            ],
          ],
        )
      ],
    );
  }
}
