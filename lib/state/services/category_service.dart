import '../models/category_model.dart';

class CategoryService {
  Future<List<CategoryModel>> fetchAllCategories() async {
    final List<CategoryModel> categories = [];
    return categories;
  }

  Future<CategoryModel?> addCategory(CategoryModel category) async {
    return category;
  }

  Future<bool> updateCategory(CategoryModel category) async {
    return true;
  }

  Future<bool> deleteCategory(int id) async {
    return true;
  }
}
