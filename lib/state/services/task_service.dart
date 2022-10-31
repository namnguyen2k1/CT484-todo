import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task_model.dart';

class TaskService {
  static const _tableName = 'task';
  static const _databaseName = 'ct484_$_tableName.db';
  static const _databaseVersion = 1;

  // final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final idType = 'TEXT PRIMARY KEY';
  final intType = 'INTEGER NOT NULL';
  final textType = 'TEXT NOT NULL';
  final boolType = 'BOOLEAN NOT NULL';
  final integerType = 'INTEGER NOT NULL';

  // Ngăn tạo mới đối tượng từ lớp: `singleton`
  static final TaskService instance = TaskService._sharedInstance();
  TaskService._sharedInstance();

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
    final databasePath = await getDatabasesPath();
    final filePath = join(databasePath, fileName);
    return await openDatabase(
      filePath,
      version: _databaseVersion,
      onCreate: _createDefaultTable,
    );
  }

  Future<void> _createDefaultTable(Database db, int version) async {
    await db.execute('''CREATE TABLE $_tableName (
      id $idType,
      categoryId $intType,
      name $textType,
      star $intType,
      color $textType,
      description $textType,
      imageUrl $textType,
      startTime $textType,
      finishTime $textType,
      isCompleted $boolType
    )''');
  }

  void close() {
    if (_defaultDatabase != null) {
      _defaultDatabase!.close();
      _defaultDatabase = null;
    }
  }

  Future<List<TaskModel>> getAll() async {
    /// raw query
    /// List<Map> list = await database.rawQuery('SELECT * FROM Test');
    /// int count = Sqflite.firstValue(await database.rawQuery('SELECT COUNT(*) FROM Test'));
    final db = await _database;
    final result = await db.query(
      _tableName,
      orderBy: 'startTime DESC',
    );
    return result.map((item) => TaskModel.fromJson(item)).toList();
  }

  Future<TaskModel?> addItem(TaskModel item) async {
    // raw query
    // int id1 = await database.rawInsert('INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456,789)');
    // int id1 = await database.rawInsert('INSERT INTO Test(name, value, num) VALUES(?, ?, ?)', ["some name", 123, 456,789]);

    final db = await _database;
    await db.insert(
      _tableName,
      item.toJson(),
    );
    return item;
  }

  Future<int> updateItem(TaskModel item) async {
    // int count = await database.rawUpdate(' UPDATE Test SET name = ?, value = ?, num = ? WHERE name = ?', ['update name', '9876', 'some name']);
    final db = await _database;
    return db.update(
      _tableName,
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteItemById(String id) async {
    // int count = await database.rawDelete(' DELETE FROM Test WHERE id = ?', [id]);
    final db = await _database;
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
