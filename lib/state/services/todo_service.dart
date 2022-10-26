import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/todo_model.dart';
import '../models/auth_token.dart';
import './firebase_service.dart';

class TodoService extends FirebaseService {
  TodoService([AuthTokenModel? authToken]) : super(authToken);

  Future<List<TodoModel>> fetchTodos([bool filterByUser = false]) async {
    final List<TodoModel> todos = [];

    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final todosUrl = Uri.parse(
        '$databaseUrl/todos.json?auth=$token&$filters',
      );
      final response = await http.get(todosUrl);
      final todosMap = json.decode(
        response.body,
      ) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(todosMap['error']);
        return todos;
      }

      final userFavoritesUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');

      final userFavoritesResponse = await http.get(
        userFavoritesUrl,
      );
      final userFavoritesMap = json.decode(
        userFavoritesResponse.body,
      );

      todosMap.forEach((todoId, Todo) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[todoId] ?? false);

        todos.add(
          Todo.fromJson({
            'id': todoId,
            ...Todo,
          }).copyWith(
            isFavorite: isFavorite,
          ),
        );
      });

      return todos;
    } catch (error) {
      print(error);
      return todos;
    }
  }

  Future<TodoModel?> addTodo(TodoModel todo) async {
    try {
      final url = Uri.parse('$databaseUrl/todos.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          todo.toJson()..addAll({'creatorId': userId}),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(
          json.decode(response.body)['error'],
        );
      }

      return todo.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateTodo(TodoModel todo) async {
    try {
      final url = Uri.parse(
        '$databaseUrl/Todos/${todo.id}.json?auth=$token',
      );
      final response = await http.patch(
        url,
        body: json.encode(todo.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception(
          json.decode(response.body)['error'],
        );
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteTodo(String id) async {
    try {
      final url = Uri.parse(
        '$databaseUrl/Todos/$id.json?auth=$token',
      );
      final response = await http.delete(url);
      if (response.statusCode != 200) {
        throw Exception(
          json.decode(response.body)['error'],
        );
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> saveFavoriteStatus(TodoModel todo) async {
    try {
      final url = Uri.parse(
        '$databaseUrl/userFavorites/$userId/${todo.id}.json?auth=$token',
      );
      final response = await http.put(
        url,
        body: json.encode(todo.isCompleted),
      );
      if (response.statusCode != 200) {
        throw Exception(
          json.decode(response.body)['error'],
        );
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
