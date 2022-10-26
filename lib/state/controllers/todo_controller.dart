import 'package:flutter/foundation.dart';

import '../services/todo_service.dart';
import '../models/todo_model.dart';
import '../models/auth_token.dart';

class TodoController with ChangeNotifier {
  List<TodoModel> _items = [];
  final TodoService _todosService;

  TodoController([AuthTokenModel? authToken])
      : _todosService = TodoService(authToken);

  set authToken(AuthTokenModel? authToken) {
    _todosService.authToken = authToken;
  }

  Future<void> fetchTodos([bool filterByUser = false]) async {
    _items = await _todosService.fetchTodos(filterByUser);
    notifyListeners();
  }

  Future<void> addTodo(TodoModel todo) async {
    final newtodo = await _todosService.addTodo(todo);
    if (newtodo != null) {
      _items.add(newtodo);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<TodoModel> get items {
    return [..._items];
  }

  List<TodoModel> get favoriteItems {
    return _items.where((todo) => todo.isCompleted).toList();
  }

  TodoModel findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> updateTodo(TodoModel todo) async {
    final index = _items.indexWhere(
      (item) => item.id == todo.id,
    );
    if (index >= 0) {
      if (await _todosService.updateTodo(todo)) {
        _items[index] = todo;
        notifyListeners();
      }
    }
  }

  Future<void> toggleFavoriteStatus(TodoModel todo) async {
    final savedStatus = todo.isCompleted;
    todo.isCompleted = !savedStatus;

    if (!await _todosService.saveFavoriteStatus(todo)) {
      todo.isCompleted = savedStatus;
    }
  }

  Future<void> deleteTodo(String id) async {
    final index = _items.indexWhere(
      (item) => item.id == id,
    );
    TodoModel? existingtodo = _items[index];
    _items.removeAt(index);
    notifyListeners();
    if (!await _todosService.deleteTodo(id)) {
      _items.insert(index, existingtodo);
      notifyListeners();
    }
  }
}
