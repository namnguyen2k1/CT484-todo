import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/category_model_change_notifier.dart';
import '../models/task_model_change_notifier.dart';

class SqfliteService {
  static const _categoryTableName = 'categories';
  static const _taskTableName = 'tasks';
  static const _databaseName = 'ct484_sqflite.db';
  static const _databaseVersion = 1;

  // Create singleton
  static final SqfliteService instance = SqfliteService._internal();
  SqfliteService._internal();

  Database? _defaultDatabase;

  Future<Database> get _database async {
    if (_defaultDatabase != null) {
      return _defaultDatabase!;
    }
    _defaultDatabase = await _initDatabase(_databaseName);
    return _defaultDatabase!;
  }

  Future<Database> _initDatabase(String fileName) async {
    WidgetsFlutterBinding.ensureInitialized();

    final databasePath = await getDatabasesPath();
    final filePath = join(databasePath, fileName);
    return await openDatabase(
      filePath,
      version: _databaseVersion,
      onCreate: _createDefaultTables,
      // cascade delete
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _createDefaultTables(Database db, int version) async {
    // Sqflite supported only: {num, String and Uint8List}
    // Article: https://github.com/tekartik/sqflite/blob/master/sqflite/doc/supported_types.md

    // id được tạo từ uuid nên cần chuyển int => text
    const idType = 'TEXT PRIMARY KEY';
    // id từ category nên cần đổi trường categoryId trong task => null
    const foreignType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    // Create category table
    await db.execute(
      '''CREATE TABLE $_categoryTableName (
      ${CategoryFields.id} $idType,
      ${CategoryFields.name} $textType,
      ${CategoryFields.code} $textType,
      ${CategoryFields.description} $textType,
      ${CategoryFields.imageUrl} $textType,
      ${CategoryFields.color} $textType,
      ${CategoryFields.createdAt} $textType
    )''',
    );

    // Create task table
    await db.execute(
      '''CREATE TABLE $_taskTableName (
      ${TaskFields.id} $idType,
      ${TaskFields.categoryId} $foreignType,
      ${TaskFields.name} $textType,
      ${TaskFields.star} $integerType,
      ${TaskFields.color} $textType,
      ${TaskFields.description} $textType,
      ${TaskFields.imageUrl} $textType,
      ${TaskFields.workingTime} $textType,
      ${TaskFields.createdAt} $textType,
      ${TaskFields.isCompleted} $integerType,
      FOREIGN KEY (${TaskFields.categoryId}) REFERENCES $_categoryTableName(${CategoryFields.id})
    )''',
    );
  }

  Future<void> close() async {
    final db = await instance._database;
    db.close();
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final db = await instance._database;
    final result = await db.query(
      _categoryTableName,
      orderBy: '${CategoryFields.createdAt} DESC',
    );
    return result.map((item) => CategoryModel.fromJson(item)).toList();
  }

  Future<CategoryModel> getCategoryById(String id) async {
    final db = await instance._database;
    final result = await db.query(
      _categoryTableName,
      where: '${CategoryFields.id} = ?',
      whereArgs: [id],
    );
    return CategoryModel.fromJson(
      result[0],
    );
  }

  Future<int> addCategory(CategoryModel item) async {
    final db = await instance._database;
    final index = await db.insert(
      _categoryTableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return index;
  }

  Future<int> updateCategory(CategoryModel item) async {
    final db = await instance._database;
    final updateRowCount = await db.update(
      _categoryTableName,
      item.toJson(),
      where: '${CategoryFields.id} = ?',
      whereArgs: [item.id],
    );
    return updateRowCount;
  }

  Future<int> deleteCategoryById(String id) async {
    final db = await instance._database;
    final deleteRowCount = await db.delete(
      _categoryTableName,
      where: '${CategoryFields.id} = ?',
      whereArgs: [id],
    );
    return deleteRowCount;
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await instance._database;
    final result = await db.query(
      _taskTableName,
      orderBy: '${TaskFields.createdAt} DESC',
    );
    return result.map((item) => TaskModel.fromJson(item)).toList();
  }

  Future<TaskModel> getTaskById(String id) async {
    final db = await instance._database;
    final result = await db.query(
      _taskTableName,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
    return TaskModel.fromJson(
      result[0],
    );
  }

  Future<int> addTask(TaskModel item) async {
    final db = await instance._database;
    final index = await db.insert(
      _taskTableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return index;
  }

  Future<int> updateTask(TaskModel item) async {
    final db = await instance._database;
    final updateRowCount = await db.update(
      _taskTableName,
      item.toJson(),
      where: '${TaskFields.id} = ?',
      whereArgs: [item.id],
    );
    return updateRowCount;
  }

  Future<int> deleteTaskById(String id) async {
    final db = await instance._database;
    final deleteRowCount = await db.delete(
      _taskTableName,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
    return deleteRowCount;
  }
}
