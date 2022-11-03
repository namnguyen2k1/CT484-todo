import 'package:flutter/foundation.dart';

import 'package:todoapp/state/services/sqflite_service.dart';
import '../models/task_model.dart';

class TaskController with ChangeNotifier {
  final _allItems = <TaskModel>[];
  final SqfliteService _service = SqfliteService.instance;

  int get itemCount => _allItems.length;
  List<TaskModel> get allItems => List.unmodifiable(_allItems);

  Future<void> getAll() async {
    final items = await _service.getAllTasks();
    _allItems.clear();
    _allItems.addAll(items);
    notifyListeners();
  }

  Future<void> addItem(TaskModel item) async {
    _allItems.add(item);
    notifyListeners();
    await _service.addTask(item);
  }

  TaskModel findById(String id) {
    return _allItems.firstWhere((item) => item.id == id);
  }

  Future<void> updateItem(TaskModel newItem) async {
    final index = _allItems.indexWhere(
      (i) => i.id == newItem.id,
    );
    _allItems[index] = newItem;
    notifyListeners();
    await _service.updateTask(newItem);
  }

  Future<void> deleteItemById(String id) async {
    final index = _allItems.indexWhere(
      (item) => item.id == id,
    );
    _allItems.removeAt(index);
    notifyListeners();
    await _service.deleteTaskById(id);
  }
}
