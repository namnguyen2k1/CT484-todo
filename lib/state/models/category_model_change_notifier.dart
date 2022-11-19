import 'package:flutter/foundation.dart';

class CategoryModel with ChangeNotifier {
  String id;
  String code;
  String name;
  String description;
  String color;
  String imageUrl;
  String createdAt;

  CategoryModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.color,
    required this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      color: json['color'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'color': color,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'CategoryModel($id $name $description $imageUrl $color $createdAt)';
  }

  void updateWith(CategoryModel category) {
    id = category.id;
    code = category.code;
    name = category.name;
    description = category.description;
    color = category.color;
    imageUrl = category.imageUrl;
    createdAt = category.createdAt;
    notifyListeners();
  }
}
