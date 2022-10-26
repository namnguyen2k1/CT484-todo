import 'package:flutter/cupertino.dart';

class TodoModel {
  final String? id;
  final String? categoryId;
  final String name;
  final String description;
  final String imageUrl;
  final String createdAt;
  final String deadlinedAt;
  final ValueNotifier<bool> _isCompleted;

  TodoModel({
    this.id,
    this.categoryId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.deadlinedAt,
    isCompleted = false,
  }) : _isCompleted = ValueNotifier(isCompleted);

  TodoModel copyWith({
    String? id,
    String? categoryId,
    String? name,
    String? description,
    String? imageUrl,
    String? createdAt,
    String? deadlinedAt,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      deadlinedAt: deadlinedAt ?? this.deadlinedAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  set isCompleted(bool newValue) {
    _isCompleted.value = newValue;
  }

  bool get isCompleted {
    return _isCompleted.value;
  }

  // set isFavorited(bool newValue) {
  //   _isFavorited.value = newValue;
  // }

  // bool get isFavorited {
  //   return _isFavorited.value;
  // }

  ValueNotifier<bool> get isCompletedListenable {
    return _isCompleted;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'deadlinedAt': deadlinedAt,
    };
  }

  static TodoModel fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      categoryId: json['categoryId'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
      deadlinedAt: json['deadlinedAt'],
    );
  }
}
