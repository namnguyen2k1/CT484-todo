class CategoryModel {
  final String id;
  final String code;
  final String name;
  final String description;
  final String color;
  final String imageUrl;
  final String createdAt;

  CategoryModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.color,
    required this.createdAt,
  });

  CategoryModel copyWith({
    String? id,
    String? code,
    String? name,
    String? description,
    String? imageUrl,
    String? color,
    String? createdAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
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
    return '$id $name $description $imageUrl $color $createdAt';
  }
}
