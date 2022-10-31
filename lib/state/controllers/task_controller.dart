import 'package:flutter/foundation.dart';

import '../services/task_service.dart';
import '../models/task_model.dart';

class TaskController with ChangeNotifier {
  final _allItems = <TaskModel>[];
  final TaskService _service = TaskService.instance;

  int get itemCount => _allItems.length;
  List<TaskModel> get allItems => List.unmodifiable(_allItems);

  Future<void> getAll() async {
    final items = await _service.getAll();
    _allItems.clear();
    _allItems.addAll(items);
    notifyListeners();
  }

  Future<void> addItem(TaskModel item) async {
    final newItem = await _service.addItem(item);
    if (newItem != null) {
      _allItems.add(newItem);
      notifyListeners();
    }
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
  }

  Future<void> deleteItemById(String id) async {
    final index = _allItems.indexWhere(
      (item) => item.id == id,
    );
    _allItems.removeAt(index);
    _service.deleteItemById(id);
    notifyListeners();
  }
}
