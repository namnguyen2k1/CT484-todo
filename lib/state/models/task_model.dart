class TaskModel {
  final String id;
  final String categoryId;
  final String name;
  final int star;
  final String color;
  final String description;
  final String imageUrl;
  final String workingTime;
  final String createdAt;
  final bool isCompleted;

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

  TaskModel copyWith({
    String? id,
    String? categoryId,
    String? name,
    int? star,
    String? color,
    String? description,
    String? imageUrl,
    String? workingTime,
    String? createdAt,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      star: star ?? this.star,
      color: color ?? this.color,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      workingTime: workingTime ?? this.workingTime,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

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
      'isCompleted': isCompleted,
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
      isCompleted: json['isCompleted'] as bool,
    );
  }

  @override
  String toString() {
    return 'TaskModel($id $categoryId $name $description $star $color $workingTime $createdAt)';
  }
}
