import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/ui/shared/dialog_utils.dart';

import '../../../state/models/todo_model.dart';
import '../../../state/controllers/todo_controller.dart';

class EditTodoScreen extends StatefulWidget {
  static const routeName = '/edit-todo';

  EditTodoScreen(
    TodoModel? todo, {
    super.key,
  }) {
    if (todo == null) {
      this.todo = TodoModel(
        id: null,
        categoryId: null,
        name: '',
        description: '',
        imageUrl: '',
        createdAt: '',
        deadlinedAt: '',
        isCompleted: false,
      );
    } else {
      this.todo = todo;
    }
  }
  late final TodoModel todo;

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late TodoModel _editedTodo;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedTodo = widget.todo;
    _imageUrlController.text = _editedTodo.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      final todosController = context.read<TodoController>();
      if (_editedTodo.id != null) {
        await todosController.updateTodo(_editedTodo);
      } else {
        await todosController.addTodo(_editedTodo);
      }
    } catch (error) {
      await showInformation(context, '', 'Something went wrong.');
    }
    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  TextFormField buildNameField() {
    return TextFormField(
      initialValue: _editedTodo.name,
      decoration: const InputDecoration(
        labelText: 'Name',
      ),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedTodo = _editedTodo.copyWith(
          name: value,
        );
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedTodo.description,
      decoration: const InputDecoration(labelText: 'Description'),
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
        _editedTodo = _editedTodo.copyWith(
          description: value,
        );
      },
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
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
        _editedTodo = _editedTodo.copyWith(
          imageUrl: value,
        );
      },
    );
  }

  Widget buildtodoPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrlController.text.isEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildNameField(),
                    buildDescriptionField(),
                    buildtodoPreview(),
                  ],
                ),
              ),
            ),
    );
  }
}
