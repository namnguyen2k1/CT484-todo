import 'package:flutter/foundation.dart';

import '../services/task_service.dart';
import '../models/task_model.dart';

class TaskController with ChangeNotifier {
  List<TaskModel> _items = [];
  final TaskService _tasksService = TaskService();

  Future<void> fetchTasks() async {
    _items = await _tasksService.fetchAllTasks();
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    final newTask = await _tasksService.addTask(task);
    if (newTask != null) {
      _items.add(newTask);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<TaskModel> get items {
    return [..._items];
  }

  TaskModel findById(int id) {
    return _items.firstWhere((task) => task.id == id);
  }

  Future<void> updateTask(TaskModel task) async {
    final index = _items.indexWhere(
      (item) => item.id == task.id,
    );
    if (index >= 0) {
      if (await _tasksService.updateTask(task)) {
        _items[index] = task;
        notifyListeners();
      }
    }
  }

  Future<void> deleteTask(int id) async {
    final index = _items.indexWhere(
      (item) => item.id == id,
    );
    TaskModel? existingTask = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _tasksService.deleteTask(id)) {
      _items.insert(index, existingTask);
      notifyListeners();
    }
  }
}
