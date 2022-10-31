import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/state/models/category_model.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/ui/shared/response_message.dart';

class EditCategoryScreen extends StatefulWidget {
  EditCategoryScreen(
    CategoryModel? category, {
    super.key,
  }) {
    if (category == null) {
      this.category = CategoryModel(
        id: '-1',
        code: '#123',
        name: 'default',
        description: 'default',
        color: '4294940672',
        createdAt: '01/11/2022',
      );
    } else {
      this.category = category;
    }
  }

  late final CategoryModel category;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  bool _isEditing = true;
  Color _selectedColor = Colors.deepOrange;
  final Map<String, dynamic> _formData = {
    'id': const Uuid().v4(),
    'name': 'default',
    'code': '#',
    'description': 'default',
    'color': '4294940672', // Colors.deepOrange
    'createdAt': 'default'
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _categoryTextEditingController = TextEditingController();

  Future<void> _handleSaveItem() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    print(_formData.toString());
    _formData['id'] = const Uuid().v4();
    await context.read<CategoryController>().addItem(
          CategoryModel.fromJson(_formData),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('New Category'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            buildFieldName(
              prefixIcon: Icons.note,
              label: 'Category Name',
            ),
            const Divider(),
            buildFieldCode(
              prefixIcon: Icons.code,
              label: 'Category Code',
            ),
            const Divider(),
            buildFieldDescription(
              prefixIcon: Icons.description,
              label: 'Description',
            ),
            const Divider(),
            buildFieldColor(context),
            const Divider(),
            buildControlButtons(context),
          ],
        ),
      ),
    );
  }

  Column buildFieldColor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pick Color'),
        const SizedBox(
          width: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return 'Invalid color!';
                  }
                  return null;
                },
                initialValue: _selectedColor.value.toString(),
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
            const SizedBox(
              width: 10,
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
              child: const Icon(
                Icons.color_lens,
                size: 60,
              ),
            ),
          ],
        ),
      ],
    );
  }

  TextFormField buildFieldName({
    required IconData prefixIcon,
    required String label,
  }) {
    return TextFormField(
      enabled: _isEditing,
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      controller: _categoryTextEditingController,
      validator: (value) {
        if (value!.isEmpty || value.length < 3) {
          return 'Invalid name!';
        }
        return null;
      },
      onSaved: (value) {
        _formData['name'] = value!;
      },
      keyboardType: TextInputType.name,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TextFormField buildFieldCode({
    required IconData prefixIcon,
    required String label,
  }) {
    return TextFormField(
      enabled: _isEditing,
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      validator: (value) {
        if (value!.isEmpty || value.length < 3) {
          return 'Invalid code!';
        }
        return null;
      },
      onSaved: (value) {
        _formData['code'] = value!;
      },
      keyboardType: TextInputType.name,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TextFormField buildFieldDescription({
    required IconData prefixIcon,
    required String label,
  }) {
    return TextFormField(
      enabled: _isEditing,
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      validator: (value) {
        if (value!.isEmpty || value.length < 3) {
          return 'Invalid description!';
        }
        return null;
      },
      onSaved: (value) {
        _formData['description'] = value!;
      },
      keyboardType: TextInputType.name,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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
              'Add Category successfully',
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
}
