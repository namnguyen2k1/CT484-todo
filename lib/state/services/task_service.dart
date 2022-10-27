import '../models/task_model.dart';

class TaskService {
  Future<List<TaskModel>> fetchAllTasks() async {
    final List<TaskModel> tasks = [];
    return tasks;
  }

  Future<TaskModel?> addTask(TaskModel task) async {
    return task;
  }

  Future<bool> updateTask(TaskModel task) async {
    return true;
  }

  Future<bool> deleteTask(int id) async {
    return true;
  }
}
