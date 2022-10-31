class CategoryModel {
  final String id;
  final String code;
  final String name;
  final String description;
  final String color;
  final String createdAt;

  CategoryModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.color,
    required this.createdAt,
  });

  CategoryModel copyWith({
    String? id,
    String? code,
    String? name,
    String? description,
    String? color,
    String? createdAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
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
      'color': color,
      'createdAt': createdAt,
    };
  }
}
