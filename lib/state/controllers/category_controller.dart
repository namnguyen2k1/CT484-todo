import 'package:flutter/foundation.dart';

import '../services/category_service.dart';
import '../models/category_model.dart';

class CategoryController with ChangeNotifier {
  List<CategoryModel> _items = [];
  final CategoryService _categoryService = CategoryService();

  Future<void> fetchAllCategories() async {
    _items = await _categoryService.fetchAllCategories();
    notifyListeners();
  }

  Future<void> addCategory(CategoryModel category) async {
    final newCategory = await _categoryService.addCategory(category);
    if (newCategory != null) {
      _items.add(newCategory);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<CategoryModel> get items {
    return [..._items];
  }

  CategoryModel findById(int id) {
    return _items.firstWhere((category) => category.id == id);
  }

  Future<void> updateCategory(CategoryModel category) async {
    final index = _items.indexWhere(
      (item) => item.id == category.id,
    );
    if (index >= 0) {
      if (await _categoryService.updateCategory(category)) {
        _items[index] = category;
        notifyListeners();
      }
    }
  }

  Future<void> deleteCategory(int id) async {
    final index = _items.indexWhere(
      (item) => item.id == id,
    );
    CategoryModel? existingcategory = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _categoryService.deleteCategory(id)) {
      _items.insert(index, existingcategory);
      notifyListeners();
    }
  }
}
