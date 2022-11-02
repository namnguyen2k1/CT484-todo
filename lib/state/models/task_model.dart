class TaskModel {
  final String id;
  final String categoryId;
  final String name;
  final int star;
  final String color;
  final String description;
  final String imageUrl;
  final String startTime;
  final String finishTime;
  bool isCompleted;

  get taskIsCompleted => isCompleted;
  set setTaskCompleted(bool result) {
    isCompleted = result;
  }

  TaskModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.star,
    required this.color,
    required this.description,
    required this.imageUrl,
    required this.startTime,
    required this.finishTime,
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
    String? startTime,
    String? finishTime,
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
      startTime: startTime ?? this.startTime,
      finishTime: finishTime ?? this.finishTime,
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
      'startTime': startTime,
      'finishTime': finishTime,
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
      startTime: json['startTime'] as String,
      finishTime: json['finishTime'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  @override
  String toString() {
    return '$id $categoryId $name $description $star $color $startTime $finishTime';
  }
}
