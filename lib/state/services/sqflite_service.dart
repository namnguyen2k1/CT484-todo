import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/category_model.dart';
import '../models/task_model.dart';

class SqfliteService {
  static const _categoryTableName = 'categories';
  static const _taskTableName = 'tasks';
  static const _databaseName = 'ct484_sqflite.db';
  static const _databaseVersion = 1;

  // Trường hợp id được tạo từ uuid nên cần chuyển int => text
  final idType = 'TEXT PRIMARY KEY';
  // Trường hợp xoá id từ category nên cần đổi trường categoryId trong task => null
  final foreignType = 'TEXT NULL';

  final integerType = 'INTEGER NOT NULL';
  final textType = 'TEXT NOT NULL';
  final boolType = 'BOOLEAN NOT NULL';

  // Create singleton
  static final SqfliteService instance = SqfliteService._sharedInstance();
  SqfliteService._sharedInstance();

  Database? _defaultDatabase;

  Future<Database> get _database async {
    if (_defaultDatabase != null) {
      return _defaultDatabase!;
    } else {
      _defaultDatabase = await _initDatabase(_databaseName);
      return _defaultDatabase!;
    }
  }

  Future<Database> _initDatabase(String fileName) async {
    WidgetsFlutterBinding.ensureInitialized();

    final databasePath = await getDatabasesPath();
    final filePath = join(databasePath, fileName);
    print('database Path: $filePath');
    return await openDatabase(
      filePath,
      version: _databaseVersion,
      onCreate: _createDefaultTables,
    );
  }

  Future<void> _createDefaultTables(Database db, int version) async {
    // Create category table
    await db.execute(
      '''CREATE TABLE $_categoryTableName (
      id $idType,
      name $textType,
      code $textType,
      description $textType,
      imageUrl $textType,
      color $textType,
      createdAt $textType
    )''',
    );

    // Create task table
    await db.execute(
      '''CREATE TABLE $_taskTableName (
      id $idType,
      categoryId $foreignType,
      name $textType,
      star $integerType,
      color $textType,
      description $textType,
      imageUrl $textType,
      workingTime $textType,
      createdAt $textType,
      isCompleted $boolType,
      FOREIGN KEY (categoryId) REFERENCES $_categoryTableName(id) ON DELETE SET NULL
    )''',
    );
  }

  void close() {
    if (_defaultDatabase != null) {
      _defaultDatabase!.close();
      _defaultDatabase = null;
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final db = await _database;
    final result = await db.query(
      _categoryTableName,
      orderBy: 'createdAt DESC',
    );
    return result.map((item) => CategoryModel.fromJson(item)).toList();
  }

  Future<CategoryModel> getCategoryById(String id) async {
    final db = await _database;
    final result = await db.query(
      _categoryTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return CategoryModel.fromJson(
      result[0],
    );
  }

  Future<int> addCategory(CategoryModel item) async {
    final db = await _database;
    final index = await db.insert(
      _categoryTableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return index;
  }

  Future<int> updateCategory(CategoryModel item) async {
    final db = await _database;
    final updateRowCount = await db.update(
      _categoryTableName,
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return updateRowCount;
  }

  Future<int> deleteCategoryById(String id) async {
    final db = await _database;
    final deleteRowCount = await db.delete(
      _categoryTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return deleteRowCount;
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await _database;
    final result = await db.query(
      _taskTableName,
      orderBy: 'startTime DESC',
    );
    return result.map((item) => TaskModel.fromJson(item)).toList();
  }

  Future<TaskModel> getTaskById(String id) async {
    final db = await _database;
    final result = await db.query(
      _taskTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return TaskModel.fromJson(
      result[0],
    );
  }

  Future<int> addTask(TaskModel item) async {
    final db = await _database;
    final index = await db.insert(
      _taskTableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return index;
  }

  Future<int> updateTask(TaskModel item) async {
    final db = await _database;
    final updateRowCount = await db.update(
      _taskTableName,
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return updateRowCount;
  }

  Future<int> deleteTaskById(String id) async {
    final db = await _database;
    final deleteRowCount = await db.delete(
      _taskTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return deleteRowCount;
  }
}
