import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todoapp/ui/shared/response_message.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({super.key});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  bool _isEditing = true;
  Color _selectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('New Category'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          buildFieldText(prefixIcon: Icons.note, label: 'Category Name'),
          const Divider(),
          buildFieldText(prefixIcon: Icons.code, label: 'Category Code'),
          const Divider(),
          buildFieldText(prefixIcon: Icons.description, label: 'Description'),
          const Divider(),
          buildFieldColor(context),
          const Divider(),
          buildControlButtons(context),
        ],
      ),
    );
  }

  Row buildControlButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
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
}
