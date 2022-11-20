import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../services/sqflite_service.dart';

import '../models/category_model_change_notifier.dart';

class CategoryController extends ChangeNotifier {
  final SqfliteService _service = SqfliteService.instance;

  final _allItems = <CategoryModel>[];

  int get itemCount => _allItems.length;
  List<CategoryModel> get allItems => List.unmodifiable(_allItems);

  Future<List<CategoryModel>> getAllCategories() async {
    final items = await _service.getAllCategories();
    _allItems.clear();
    _allItems.addAll(items);
    notifyListeners();
    return items;
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
    _allItems[index].updateWith(newItem);
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
