class CategoryModel {
  final int id;
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
    int? id,
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
}
