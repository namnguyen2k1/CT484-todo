import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// database: todo
/// table: category, task

class SqfLiteService {
  static const _databaseName = "ct484_todo.db";
  static const _databaseVersion = 1;

  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT NOT NULL';
  final boolType = 'BOOLEAN NOT NULL';
  final integerType = 'INTEGER NOT NULL';

// Ngăn tạo mới đối tượng từ lớp: `singleton`
  static final SqfLiteService instance = SqfLiteService._sharedInstance();
  SqfLiteService._sharedInstance();

  Database? _todoDatabase;

  Future<Database> get _database async {
    if (_todoDatabase != null) {
      return _todoDatabase!;
    } else {
      _todoDatabase = await _initDatabase(_databaseName);
      return _todoDatabase!;
    }
  }

  Future<Database> _initDatabase(String fileName) async {
    final databasePath = await getDatabasesPath();
    final filePath = join(databasePath, fileName);
    return await openDatabase(
      filePath,
      version: _databaseVersion,
      onCreate: _createTodoItemTable,
    );
  }

  Future<void> _createTodoItemTable(Database db, int version) async {
    await db.execute('''CREATE TABLE category (
      id INTEGER PRIMARY KEY NOT NULL,
      name TEXT,
      code TEXT,
      description TEXT,
      color TEXT,
      createdAt TEXT,
    )''');
  }

  void close() {
    if (_todoDatabase != null) {
      _todoDatabase!.close();
      _todoDatabase = null;
    }
  }
}
