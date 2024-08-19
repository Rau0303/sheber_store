// product_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sheber_market/models/product.dart';

class ProductHelper {
  static final ProductHelper _instance = ProductHelper._internal();
  factory ProductHelper() => _instance;
  ProductHelper._internal();

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
          CREATE TABLE products (
            id INTEGER PRIMARY KEY,
            barcode TEXT,
            name TEXT,
            selling_price REAL,
            category TEXT,
            unit TEXT,
            quantity INTEGER,
            supplier TEXT,
            description TEXT,
            photo TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<void> clearProducts() async {
    final db = await database;
    await db.delete('products');
  }
}
