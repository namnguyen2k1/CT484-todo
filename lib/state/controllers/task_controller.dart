import 'package:flutter/foundation.dart';

import 'package:todoapp/state/services/sqflite_service.dart';
import '../models/task_model_change_notifier.dart';

class TaskController extends ChangeNotifier {
  final _allItems = <TaskModel>[];
  final SqfliteService _service = SqfliteService.instance;

  int get itemCount => _allItems.length;
  List<TaskModel> get allItems => List.unmodifiable(_allItems);

  Future<List<TaskModel>> getAllTasks() async {
    final items = await _service.getAllTasks();
    _allItems.clear();
    _allItems.addAll(items);
    notifyListeners();
    return items;
  }

  Future<void> addItem(TaskModel item) async {
    _allItems.add(item);
    notifyListeners();
    await _service.addTask(item);
  }

  TaskModel findById(String id) {
    return _allItems.firstWhere((item) => item.id == id);
  }

  List<TaskModel> findTasksByCategoryId(String id) {
    return _allItems.where((element) => element.categoryId == id).toList();
  }

  Future<void> updateItem(TaskModel newItem) async {
    final index = _allItems.indexWhere(
      (i) => i.id == newItem.id,
    );
    _allItems[index].updateWith(newItem);
    notifyListeners();
    await _service.updateTask(newItem);
  }

  Future<void> swapTwoItem(int first, int second) async {
    final temp = _allItems[first];
    _allItems[first] = _allItems[second];
    _allItems[second] = temp;
    notifyListeners();
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
