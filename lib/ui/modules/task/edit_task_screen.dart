import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:todoapp/ui/shared/dialog_utils.dart';
import 'package:todoapp/ui/shared/rate_star.dart';
import 'package:uuid/uuid.dart';
import '../../../state/models/task_model.dart';
import '../../../state/controllers/task_controller.dart';
import '../../shared/response_message.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeName = '/edit-task';

  EditTaskScreen(
    TaskModel? todo, {
    super.key,
  }) {
    if (todo == null) {
      this.todo = TaskModel(
        id: '-1',
        categoryId: '-1',
        name: '',
        star: 1,
        color: "4294940672",
        description: '',
        imageUrl: '',
        startTime: DateTime.now().toString(),
        finishTime: DateTime.now().toString(),
        isCompleted: false,
      );
    } else {
      this.todo = todo;
    }
  }

  late final TaskModel todo;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _taskTextEditingController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final GlobalKey<FormState> _taskFormKey = GlobalKey();
  late TaskModel _editedTodo;
  var _isLoading = false;
  int _starCount = 1;
  Color _selectedColor = Colors.white;
  int _selectedRank = 0;

  final Map<String, dynamic> _formData = {
    'id': '-1',
    'categoryId': '-1',
    'name': '',
    'star': 1,
    'color': "4294940672",
    'description': '',
    'imageUrl': '',
    'startTime': DateTime.now().day.toString(),
    'finishTime': DateTime.now().day.toString(),
    'isCompleted': false,
  };

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  Future<void> _handleSaveItem() async {
    if (!_taskFormKey.currentState!.validate()) {
      return;
    }
    _taskFormKey.currentState!.save();
    print(_formData.toString());
    _formData['id'] = const Uuid().v4();
    await context.read<TaskController>().addItem(
          TaskModel.fromJson(_formData),
        );
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_taskTextEditingController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedTodo = widget.todo;
    _taskTextEditingController.text = _editedTodo.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _taskTextEditingController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Row buildControlButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            _handleSaveItem();
            ScaffoldMessengerCustom.showSuccessMessage(
              context,
              'Add Task successfully',
            );
            // Navigator.pop(context);
          },
          icon: const Icon(Icons.save),
          label: const Text('Add'),
        ),
        const SizedBox(
          width: 50,
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.skip_previous),
          label: const Text('Back'),
        ),
      ],
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
          initialValue: _editedTodo.name,
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
          initialValue: _editedTodo.description,
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
      controller: _taskTextEditingController,
      focusNode: _imageUrlFocusNode,
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
                        _taskTextEditingController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('New Task'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _taskFormKey,
                child: ListView(
                  children: <Widget>[
                    buildNameField(),
                    buildDescriptionField(),
                    buildRankField(),
                    buildCategoryList(),
                    buildFieldColor(context),
                    // buildTaskImagePreview(),
                    const Divider(),
                    buildControlButtons(context)
                  ],
                ),
              ),
            ),
    );
  }

  Column buildRankField() {
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
              initialLabelIndex: _selectedRank,
              totalSwitches: 3,
              labels: const ['Easy', 'Middle', 'Hard'],
              onToggle: (index) {
                final rateStar = <int>[1, 2, 3];
                print('switched to: $index ${rateStar[index!]}');
                setState(() {
                  _starCount = rateStar[index];
                  _selectedRank = index;
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
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            _formData['color'] =
                                _selectedColor.value.toString();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(
                Icons.color_lens,
                size: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column buildCategoryList() {
    final listCategory = context.read<CategoryController>().allItems;
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
}
