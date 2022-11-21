import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/state/controllers/category_controller.dart';
import 'package:todoapp/state/models/category_model_change_notifier.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import 'package:todoapp/ui/shared/custom_snackbar.dart';

class EditCategoryScreen extends StatefulWidget {
  EditCategoryScreen(
    CategoryModel? category, {
    super.key,
  }) {
    if (category != null) {
      this.category = category;
    } else {
      this.category = CategoryModel(
        id: const Uuid().v4(),
        code: '',
        name: '',
        description: '',
        imageUrl: FakeData.icons[0]['path'],
        color: Colors.greenAccent.value.toString(),
        createdAt: DateTime.now().toString(),
      );
    }
  }

  late final CategoryModel category;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  bool _isEditing = true;
  late Color _selectedColor;
  Map<String, dynamic> _formData = {
    'id': '',
    'name': '',
    'code': '',
    'description': '',
    'imageUrl': FakeData.icons[0]['path'],
    'color': '',
    'createdAt': ''
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _fieldNameFocusNode = FocusNode();
  final _categoryTextEditingController = TextEditingController();
  final _listIcons = FakeData.icons;
  int _selectedIcon = 0;

  @override
  initState() {
    final item = widget.category;
    _formData = {
      'id': item.id,
      'name': item.name,
      'code': item.code,
      'description': item.description,
      'imageUrl': item.imageUrl,
      'color': item.color,
      'createdAt': item.createdAt
    };
    _selectedColor = Color(int.parse(item.color));
    for (var index = 0; index < _listIcons.length; index++) {
      if (_listIcons[index]['path'] == item.imageUrl) {
        _selectedIcon = index;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _fieldNameFocusNode.dispose();
    _categoryTextEditingController.dispose();
    super.dispose();
  }

  Future<void> _handleAddItem() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    await context
        .read<CategoryController>()
        .addItem(CategoryModel.fromJson(_formData));
    if (mounted) {
      Navigator.pop(context);
      CustomSnackBar.showQuickMessage(
        context,
        'Thêm danh mục mới thành công!',
      );
    }
  }

  Future<void> _handleSaveItem() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    await context
        .read<CategoryController>()
        .updateItem(CategoryModel.fromJson(_formData));
    if (mounted) {
      Navigator.pop(context);
      CustomSnackBar.showQuickMessage(
        context,
        'Chỉnh sửa danh mục thành công!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: _formData['code'] != '',
        centerTitle: _formData['code'] == '',
        title: Text(
          _formData['code'] == '' ? 'Tạo Danh Mục Mới' : 'Chỉnh Sửa Danh Mục',
        ),
        actions: [
          if (_formData['code'] != '') ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: _handleSaveItem,
              child: const Icon(Icons.save),
            ),
          ]
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            buildFieldName(
              prefixIcon: Icons.note,
              label: 'Tên danh mục',
            ),
            const Divider(),
            buildFieldCode(
              prefixIcon: Icons.code,
              label: 'Mã danh mục',
            ),
            buildListIcons(context),
            const Divider(),
            buildFieldDescription(
              prefixIcon: Icons.description,
              label: 'Mô tả',
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

  Column buildListIcons(BuildContext context) {
    const maxSizeImage = 60;
    final sizeImage =
        (MediaQuery.of(context).size.width / maxSizeImage).round();
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text('Chọn icon:'),
        ),
        GridView.count(
            crossAxisCount: sizeImage,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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

  Column buildFieldColor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Chọn màu sắc:'),
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
                          child: const Text('Đóng'),
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {});
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(
                Icons.color_lens,
                size: 60,
                color: Theme.of(context).focusColor,
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
      autofocus: true,
      focusNode: _fieldNameFocusNode,
      textInputAction: TextInputAction.next,
      enabled: _isEditing,
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      initialValue: _formData['name'],
      validator: (value) {
        if (value!.isEmpty || value.length < 3) {
          return 'Nhập tên danh mục';
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
      textInputAction: TextInputAction.next,
      enabled: _isEditing,
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập mã danh mục!';
        }
        if (value.length != 3) {
          return 'Mã danh mục phải gồm 3 kí tự số';
        }
        return null;
      },
      onSaved: (value) {
        _formData['code'] = value!;
      },
      initialValue: _formData['code'],
      keyboardType: TextInputType.number,
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
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      enabled: _isEditing,
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      validator: (value) {
        if (value!.isEmpty || value.length < 3) {
          return 'Mô tả phải nhiều hơn 3 kí tự!';
        }
        return null;
      },
      onSaved: (value) {
        var filterContent = value!;
        while (filterContent[filterContent.length - 1] == '\n') {
          filterContent = filterContent.substring(0, filterContent.length - 1);
        }
        _formData['description'] = filterContent;
      },
      initialValue: _formData['description'],
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
        if (_formData['code'] == '') ...[
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
          ElevatedButton.icon(
            onPressed: _handleAddItem,
            icon: const Icon(Icons.add_circle),
            label: const Text('Thêm'),
          ),
        ]
      ],
    );
  }
}
