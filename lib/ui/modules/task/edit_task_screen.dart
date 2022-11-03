import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:todoapp/ui/shared/custom_dialog.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import 'package:uuid/uuid.dart';
import '../../../state/models/task_model.dart';
import '../../../state/controllers/task_controller.dart';
import '../../shared/custom_snackbar.dart';

class EditTaskScreen extends StatefulWidget {
  late final TaskModel todo;

  EditTaskScreen(
    TaskModel? todo, {
    super.key,
  }) {
    if (todo == null) {
      this.todo = TaskModel(
        id: const Uuid().v4(),
        categoryId: '',
        name: '',
        star: 1,
        color: Colors.deepOrange.value.toString(),
        description: '',
        imageUrl: 'assets/images/splash_icon.png',
        workingTime: '1800',
        createdAt: DateTime.now().toString(),
        isCompleted: false,
      );
    } else {
      this.todo = todo;
    }
  }

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final GlobalKey<FormState> _taskFormKey = GlobalKey();
  final _taskTextEditingController = TextEditingController();
  final _listIcons = FakeData.icons;
  late int _starCount;
  late Color _selectedColor;
  int _selectedIcon = 0;

  Map<String, dynamic> _formData = {
    'id': '',
    'categoryId': '',
    'name': '',
    'star': 1,
    'color': "",
    'description': '',
    'imageUrl': '',
    'workingTime': '',
    'createdAt': '',
    'isCompleted': false,
  };

  @override
  void initState() {
    final item = widget.todo;
    _formData = {
      'id': item.id,
      'categoryId': item.categoryId,
      'name': item.name,
      'star': item.star,
      'color': item.color,
      'description': item.description,
      'imageUrl': item.imageUrl,
      'workingTime': item.workingTime,
      'createdAt': item.createdAt,
      'isCompleted': item.isCompleted
    };
    _selectedColor = Color(int.parse(item.color));
    _starCount = item.star;
    for (var index = 0; index < _listIcons.length; index++) {
      if (_listIcons[index]['path'] == item.imageUrl) {
        _selectedIcon = index;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _taskTextEditingController.dispose();
    // _imageUrlFocusNode.dispose();
    super.dispose();
  }

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  Future<void> _handleAddItem() async {
    if (!_taskFormKey.currentState!.validate()) {
      return;
    }
    _taskFormKey.currentState!.save();
    print(_formData.toString());
    await context.read<TaskController>().addItem(
          TaskModel.fromJson(_formData),
        );

    // _resetForm
    _formData = {
      'id': const Uuid().v4(),
      'categoryId': '',
      'name': '',
      'star': 1,
      'color': Colors.deepOrange.value.toString(),
      'description': '',
      'imageUrl': 'assets/images/splash_icon.png',
      'workingTime': '30:00',
      'createdAt': DateTime.now().toString(),
      'isCompleted': false,
    };

    if (mounted) {
      SnackBarCustom.showSuccessMessage(
        context,
        'Tạo công việc mới thành công!',
      );
    }
  }

  Future<void> _handleSaveItem() async {
    if (!_taskFormKey.currentState!.validate()) {
      return;
    }
    _taskFormKey.currentState!.save();
    print(_formData.toString());
    await context
        .read<TaskController>()
        .updateItem(TaskModel.fromJson(_formData));

    if (mounted) {
      Navigator.pop(context);
      SnackBarCustom.showSuccessMessage(
        context,
        'Lưu thông tin công việc thành công',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(_formData['name'] == ''
            ? 'Tạo công việc mới'
            : 'Chỉnh sửa công việc'),
      ),
      body: Form(
        key: _taskFormKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildListIcons(context),
            buildRankField(),
            buildCategoryList(),
            buildFieldColor(context),
            // buildTaskImagePreview(),
            const Divider(),
            buildControlButtons(context)
          ],
        ),
      ),
    );
  }

  Column buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Name'),
        ),
        TextFormField(
          initialValue: _formData['name'],
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          // autofocus: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please provide a value.';
            }
            return null;
          },
          onSaved: (value) {
            _formData['name'] = value!;
          },
        ),
      ],
    );
  }

  Column buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Description'),
        ),
        TextFormField(
          initialValue: _formData['description'],
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a description.';
            }
            if (value.length < 10) {
              return 'Should be at least 10 characters long.';
            }
            return null;
          },
          onSaved: (value) {
            _formData['description'] = value!;
          },
        ),
      ],
    );
  }

  Column buildListIcons(BuildContext context) {
    const maxSizeImage = 60;
    final sizeImage =
        (MediaQuery.of(context).size.width / maxSizeImage).round();
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text('Icon'),
        ),
        GridView.count(
            crossAxisCount: sizeImage,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            physics:
                const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true, // You won't see infinite size error
            children: _listIcons.map((e) {
              int index = _listIcons.indexOf(e);
              return IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    _selectedIcon = index;
                  });
                  _formData['imageUrl'] = e['path'];
                },
                icon: Container(
                  decoration: BoxDecoration(
                    border: index == _selectedIcon
                        ? Border.all(
                            color: Theme.of(context).focusColor, width: 2.0)
                        : Border.all(color: Colors.transparent, width: 0.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                  child: Image.asset(e['path']),
                ),
              );
            }).toList()),
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(),
        labelText: 'Enter image url',
      ),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,

      initialValue: _formData['imageUrl'],
      // controller: _taskTextEditingController,
      // focusNode: _imageUrlFocusNode,
      // onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a image URL';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL';
        }
        return null;
      },
      onSaved: (value) {
        _formData['imageUrl'] = value!;
      },
    );
  }

  Column buildTaskImagePreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Image'),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _taskTextEditingController.text.isEmpty
                  ? const Align(
                      alignment: Alignment.center,
                      child: Text('Review'),
                    )
                  : FittedBox(
                      child: Image.network(
                        _formData['imageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: buildImageURLField(),
            )
          ],
        ),
      ],
    );
  }

  Column buildRankField() {
    const listRank = ['Easy', 'Middle', 'Hard'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text('Rank'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RateStar(starCount: _starCount),
            ToggleSwitch(
              initialLabelIndex: _starCount - 1,
              totalSwitches: 3,
              labels: listRank,
              onToggle: (index) {
                print('switched to: $index ${listRank[index!]}');
                setState(() {
                  _starCount = index + 1;
                  _formData['star'] = _starCount;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Column buildFieldColor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text('Color'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _formData['color'] = _selectedColor.value.toString();
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  label: Text(_selectedColor.value.toString()),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: BlockPicker(
                        pickerColor: Colors.white,
                        onColorChanged: (color) {
                          setState(() {
                            _selectedColor = color;
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(
                Icons.color_lens,
                size: 50,
                color: Theme.of(context).focusColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column buildCategoryList() {
    var listCategory = context.read<CategoryController>().allItems;
// bug khi chưa build Category
    final customWidths = List.generate(listCategory.length, (index) => 100.0);
    final labels = listCategory.map((item) => item.name).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text('Category Tag'),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Scrollbar(
            child: ToggleSwitch(
              customWidths: customWidths,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              labels: labels,
              onToggle: (index) {
                _formData['categoryId'] = listCategory[index!].id;
              },
            ),
          ),
        ),
      ],
    );
  }

  Row buildControlButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_left),
          label: const Text('Back'),
        ),
        const SizedBox(
          width: 50,
        ),
        if (_formData['name'] == '') ...[
          ElevatedButton.icon(
            onPressed: _handleAddItem,
            icon: const Icon(Icons.add_circle),
            label: const Text('Add'),
          ),
        ] else ...[
          ElevatedButton.icon(
            onPressed: _handleSaveItem,
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ],
    );
  }
}
