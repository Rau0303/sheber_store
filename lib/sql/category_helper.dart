// category_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sheber_market/models/category.dart';

class CategoryHelper {
  static final CategoryHelper _instance = CategoryHelper._internal();
  factory CategoryHelper() => _instance;
  CategoryHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE categories (
            id INTEGER PRIMARY KEY,
            name TEXT,
            photo_url TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertCategory(Category category) async {
    final db = await database;
    await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Category>> getCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');

    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  Future<void> clearCategories() async {
    final db = await database;
    await db.delete('categories');
  }
}
