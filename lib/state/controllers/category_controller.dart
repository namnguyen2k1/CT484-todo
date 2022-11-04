import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todoapp/ui/modules/utilities/fake_data.dart';

import '../services/sqflite_service.dart';
import '../models/category_model.dart';

class CategoryController with ChangeNotifier {
  final SqfliteService _service = SqfliteService.instance;

  final _allItems = <CategoryModel>[...FakeData.categorise];

  int get itemCount => _allItems.length;
  List<CategoryModel> get allItems => List.unmodifiable(_allItems);

  Future<void> getAll() async {
    final items = await _service.getAllCategories();
    _allItems.addAll([...items]);
    notifyListeners();
  }

  Future<void> addItem(CategoryModel item) async {
    _allItems.add(item);
    notifyListeners();
    await _service.addCategory(item);
  }

  CategoryModel findById(String id) {
    return _allItems.firstWhere((item) => item.id == id);
  }

  Future<void> updateItem(CategoryModel newItem) async {
    final index = _allItems.indexWhere(
      (i) => i.id == newItem.id,
    );
    _allItems[index] = newItem;
    notifyListeners();
    await _service.updateCategory(newItem);
  }

  Future<void> deleteItem(String id) async {
    final index = _allItems.indexWhere(
      (item) => item.id == id,
    );
    _allItems.removeAt(index);
    notifyListeners();
    await _service.deleteCategoryById(id);
  }
}
