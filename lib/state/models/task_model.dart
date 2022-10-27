class TaskModel {
  final int id;
  final int categoryId;
  final String name;
  final int star;
  final String color;
  final String description;
  final String imageUrl;
  final String startTime;
  final String finishTime;
  final bool isCompleted;

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
    int? id,
    int? categoryId,
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

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'description': description,
  //     'imageUrl': imageUrl,
  //     'startTime': startTime,
  //     'finishTime': finishTime,
  //   };
  // }

  // static TaskModel fromJson(Map<String, dynamic> json) {
  //   return TaskModel(
  //     id: json['id'],
  //     categoryId: json['categoryId'],
  //     name: json['name'],
  //     description: json['description'],
  //     imageUrl: json['imageUrl'],
  //     startTime: json['startTime'],
  //     finishTime: json['finishTime'],
  //   );
  // }
}
