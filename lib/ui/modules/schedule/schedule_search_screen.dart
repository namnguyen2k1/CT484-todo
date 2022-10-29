import 'package:flutter/material.dart';

class ScheduleSearchScreen extends StatefulWidget {
  const ScheduleSearchScreen({super.key});

  @override
  State<ScheduleSearchScreen> createState() => _ScheduleSearchScreenState();
}

class _ScheduleSearchScreenState extends State<ScheduleSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search task'),
      ),
      body: ListView(
        children: [
          buildNameField(),
          buildRecentSearchValue(),
          buildSearchResults()
        ],
      ),
    );
  }

  Container buildRecentSearchValue() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: const [
          Icon(Icons.settings_backup_restore),
          SizedBox(width: 10),
          Text('Recent search'),
        ],
      ),
    );
  }

  Container buildSearchResults() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Text('Result'),
      ),
    );
  }

  Container buildNameField() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'task, category, tip,..',
          suffixIcon: IconButton(
            onPressed: () {
              print('Search...');
            },
            icon: const Icon(Icons.search),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.name,
        // textInputAction: TextInputAction.next,
        // autofocus: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please provide a value.';
          }
          return null;
        },
        onSaved: (value) {
          // _editedTodo = _editedTodo.copyWith(
          //   name: value,
          // );
        },
      ),
    );
  }
}
