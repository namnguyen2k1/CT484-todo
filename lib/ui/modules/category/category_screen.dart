import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todoapp/ui/shared/response_message.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool _isEditing = true;
  Color _selectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Category'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TextFormField(
            enabled: _isEditing,
            onTap: () {
              setState(() {
                _isEditing = true;
              });
            },
            keyboardType: TextInputType.name,
            obscureText: false,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.note,
                size: 20,
              ),
              border: OutlineInputBorder(),
              labelText: 'Category Name',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          buildFieldText(prefixIcon: Icons.code, label: 'Category Code'),
          const Divider(),
          buildFieldText(prefixIcon: Icons.description, label: 'Description'),
          const Divider(),
          buildFieldColor(context),
          const Divider(),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessengerCustom.showSuccessMessage(
                  context,
                  'Add Category successfully',
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text('Add'),
            ),
          ),
        ],
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
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
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

  TextFormField buildFieldText(
      {required IconData prefixIcon, required String label}) {
    return TextFormField(
      enabled: _isEditing,
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      keyboardType: TextInputType.name,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
        ),
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
