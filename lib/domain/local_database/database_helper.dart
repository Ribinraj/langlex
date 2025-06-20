import 'package:langlex/data/models/Data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('data_items.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE data_items(
        id INTEGER PRIMARY KEY,
        img TEXT,
        mp3 TEXT
      )
    ''');
  }

  Future<void> insertDataItem(DataItem item) async {
    final db = await database;
    await db.insert('data_items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<DataItem>> getAllDataItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('data_items');
    return List.generate(maps.length, (i) {
      return DataItem.fromMap(maps[i]);
    });
  }

  // New method to clear all data
  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('data_items');
  }

  // New method to check if data exists
  Future<bool> hasData() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM data_items')
    ) ?? 0;
    return count > 0;
  }
}