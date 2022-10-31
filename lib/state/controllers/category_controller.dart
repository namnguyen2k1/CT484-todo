import 'package:flutter/foundation.dart';

import '../services/category_service.dart';
import '../models/category_model.dart';

class CategoryController with ChangeNotifier {
  final _allItems = <CategoryModel>[];
  final CategoryService _service = CategoryService.instance;

  int get itemCount => _allItems.length;
  List<CategoryModel> get allItems => List.unmodifiable(_allItems);

  Future<void> getAll() async {
    final items = await _service.getAll();
    _allItems.clear();
    _allItems.addAll(items);
    notifyListeners();
  }

  Future<void> addItem(CategoryModel item) async {
    final newItem = await _service.addItem(item);
    print('in controller: $newItem');
    _allItems.add(newItem);
    notifyListeners();
  }

  CategoryModel findById(String id) {
    return _allItems.firstWhere((item) => item.id == id);
  }

  Future<void> updateCategory(CategoryModel newItem) async {
    final index = _allItems.indexWhere(
      (i) => i.id == newItem.id,
    );
    _allItems[index] = newItem;
    notifyListeners();
  }

  Future<void> deleteItem(String id) async {
    final index = _allItems.indexWhere(
      (item) => item.id == id,
    );
    _service.deleteItemById(id);
    _allItems.removeAt(index);
    notifyListeners();
  }
}
