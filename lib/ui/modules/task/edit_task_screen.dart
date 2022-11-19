import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uuid/uuid.dart';

import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:todoapp/ui/modules/utilities/format_time.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import '../../../state/models/task_model_change_notifier.dart';
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
        name: '__________',
        star: 1,
        color: Colors.deepPurpleAccent.value.toString(),
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

  final _fieldNameFocusNode = FocusNode();
  final _taskTextEditingController = TextEditingController();
  final _listIcons = FakeData.icons;
  late int _starCount;
  late Color _selectedColor;
  int _selectedCategoryIndex = 0;
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
    'isCompleted': 0,
  };

  final int _minSlider = 5;
  final int _maxSlider = 120;
  late int _currentSliderValue;

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
      'isCompleted': item.isCompleted ? 1 : 0
    };
    _currentSliderValue = int.parse(item.workingTime) ~/ 60;
    _selectedColor = Color(int.parse(item.color));
    _starCount = item.star;
    for (var index = 0; index < _listIcons.length; index++) {
      if (_listIcons[index]['path'] == item.imageUrl) {
        _selectedIcon = index;
      }
    }
    final category = context.read<CategoryController>().allItems;
    _formData['categoryId'] = category[0].id;
    _selectedCategoryIndex = 0;
    for (var index = 0; index < category.length; index++) {
      if (category[index].id == item.categoryId) {
        _selectedCategoryIndex = index;
        _formData['categoryId'] = category[index].id;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _fieldNameFocusNode.dispose();
    _taskTextEditingController.dispose();
    super.dispose();
  }

  Future<void> _handleAddItem() async {
    if (!_taskFormKey.currentState!.validate()) {
      return;
    }
    _taskFormKey.currentState!.save();
    _formData['workingTime'] = '${_currentSliderValue * 60}';
    await context.read<TaskController>().addItem(
          TaskModel.fromJson(_formData),
        );

    if (mounted) {
      Navigator.pop(context);
      CustomSnackBar.showQuickMessage(
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
    _formData['workingTime'] = '${_currentSliderValue * 60}';
    await context
        .read<TaskController>()
        .updateItem(TaskModel.fromJson(_formData));

    if (mounted) {
      Navigator.pop(context);
      CustomSnackBar.showQuickMessage(
        context,
        'Chỉnh sửa công việc thành công',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = Theme.of(context).focusColor;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(_formData['name'] == '__________'
            ? 'Tạo công việc mới'
            : 'Chỉnh sửa công việc'),
      ),
      body: Form(
        key: _taskFormKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            buildNameField(),
            const Divider(),
            buildDescriptionField(),
            const Divider(),
            buildTimeField(currentColor),
            buildListIcons(context),
            const Divider(),
            buildRankField(),
            const Divider(),
            buildFieldColor(context),
            const Divider(),
            buildCategoryList(),
            const Divider(),
            buildControlButtons(context)
          ],
        ),
      ),
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      autofocus: true,
      focusNode: _fieldNameFocusNode,
      textInputAction: TextInputAction.next,
      initialValue: _formData['name'] == '__________' ? '' : _formData['name'],
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: const OutlineInputBorder(),
        labelText: 'Tên công việc',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).focusColor,
        ),
      ),
      // autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập tên công việc!';
        }
        return null;
      },
      onSaved: (value) {
        _formData['name'] = value!;
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      initialValue: _formData['description'],
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: const OutlineInputBorder(),
        labelText: 'Mô tả công việc',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).focusColor,
        ),
      ),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập mô tả công việc!';
        }
        if (value.length < 5) {
          return 'Nhập mô tả nhiều hơn 5 kí tự!';
        }
        return null;
      },
      onSaved: (value) {
        _formData['description'] = value!;
      },
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
          child: Text(
            'Chọn icon:',
            style: TextStyle(
              color: Theme.of(context).focusColor,
            ),
          ),
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

  Column buildRankField() {
    const listRank = ['Dễ', 'Trung bình', 'Khó'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Chọn độ khó:',
            style: TextStyle(
              color: Theme.of(context).focusColor,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RateStar(starCount: _starCount),
            ToggleSwitch(
              initialLabelIndex: _starCount - 1,
              totalSwitches: 3,
              minWidth: 90,
              labels: listRank,
              onToggle: (index) {
                setState(() {
                  _starCount = index! + 1;
                });
                _formData['star'] = _starCount;
              },
            ),
          ],
        ),
      ],
    );
  }

  Column buildTimeField(Color currentColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chọn thời gian:',
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                ),
              ),
              Text(
                FormatTime.converSecondsToText(
                  _currentSliderValue * 60,
                ),
              )
            ],
          ),
        ),
        Slider(
          inactiveColor: currentColor.withOpacity(0.2),
          activeColor: currentColor,
          value: _currentSliderValue.toDouble(),
          min: _minSlider.toDouble(),
          max: _maxSlider.toDouble(),
          divisions: _maxSlider ~/ _minSlider - 1,
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value.toInt();
            });
          },
        ),
      ],
    );
  }

  Column buildFieldColor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Chọn màu sắc:',
            style: TextStyle(
              color: Theme.of(context).focusColor,
            ),
          ),
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
                          child: const Text('Đóng'),
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
    final listCategory = context.watch<CategoryController>().allItems;
    final customWidths = List.generate(listCategory.length, (index) => 100.0);
    final labels = listCategory.map((item) => item.name).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Chọn danh mục:',
            style: TextStyle(
              color: Theme.of(context).focusColor,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Scrollbar(
            child: ToggleSwitch(
              customWidths: customWidths,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: _selectedCategoryIndex,
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
          label: const Text('Đóng'),
        ),
        const SizedBox(
          width: 50,
        ),
        if (_formData['name'] == '__________') ...[
          ElevatedButton.icon(
            onPressed: _handleAddItem,
            icon: const Icon(Icons.add_circle),
            label: const Text('Thêm'),
          ),
        ] else ...[
          ElevatedButton.icon(
            onPressed: _handleSaveItem,
            icon: const Icon(Icons.save),
            label: const Text('Lưu'),
          ),
        ],
      ],
    );
  }
}
