import 'package:flutter/foundation.dart';

class TaskModel with ChangeNotifier {
  String id;
  String categoryId;
  String name;
  int star;
  String color;
  String description;
  String imageUrl;
  String workingTime;
  String createdAt;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.star,
    required this.color,
    required this.description,
    required this.imageUrl,
    required this.workingTime,
    required this.createdAt,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'star': star,
      'color': color,
      'description': description,
      'imageUrl': imageUrl,
      'workingTime': workingTime,
      'createdAt': createdAt,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      star: json['star'] as int,
      color: json['color'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      workingTime: json['workingTime'] as String,
      createdAt: json['createdAt'] as String,
      isCompleted: json['isCompleted'] == 1 ? true : false,
    );
  }

  @override
  String toString() {
    return 'TaskModel($id $categoryId $name $description $star $color $workingTime $createdAt ${isCompleted ? 1 : 0})';
  }

  void updateWith(TaskModel task) {
    id = task.id;
    categoryId = task.categoryId;
    name = task.name;
    star = task.star;
    color = task.color;
    description = task.description;
    imageUrl = task.imageUrl;
    workingTime = task.workingTime;
    createdAt = task.createdAt;
    isCompleted = task.isCompleted;
    notifyListeners();
  }
}
