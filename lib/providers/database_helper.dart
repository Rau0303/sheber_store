import 'dart:async';
import 'package:sheber_market/models/cart_item.dart';
import 'package:sheber_market/models/users.dart';
import 'package:sheber_market/models/favorite_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sheber_market/models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        phone_number TEXT,
        photo TEXT
      )
    ''');

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

    await db.execute('''
      CREATE TABLE favorites (
        product_id INTEGER PRIMARY KEY
      )
    ''');

    await db.execute('''
      CREATE TABLE cart (
        product_id INTEGER PRIMARY KEY,
        quantity INTEGER
      )
    ''');
  }

  // Методы для работы с таблицей пользователей
  Future<void> insertUser(User user) async {
    Database db = await instance.database;
    await db.insert('users', user.toMap());
  }

  Future<List<User>> queryAllUsers() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<void> deleteUser(int id) async {
    Database db = await instance.database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Методы для работы с таблицей товаров
  Future<void> insertProduct(Product product) async {
    Database db = await instance.database;
    await db.insert('products', product.toMap());
  }

  Future<List<Product>> queryAllProducts() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<void> deleteProduct(int id) async {
    Database db = await instance.database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Методы для работы с таблицей избранного
  Future<void> insertFavoriteItem(FavoriteItem favoriteItem) async {
    Database db = await instance.database;
    await db.insert('favorites', favoriteItem.toMap());
  }

  Future<List<FavoriteItem>> queryAllFavoriteItems() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (i) {
      return FavoriteItem.fromMap(maps[i]);
    });
  }

  Future<void> deleteFavoriteItem(int productId) async {
    Database db = await instance.database;
    await db.delete(
      'favorites',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
  }

  // Методы для работы с таблицей корзины
  Future<void> insertCartItem(CartItem cartItem) async {
    Database db = await instance.database;
    await db.insert('cart', cartItem.toMap());
  }

  Future<List<CartItem>> queryAllCartItems() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('cart');

    return List.generate(maps.length, (i) {
      return CartItem.fromMap(maps[i]);
    });
  }

  Future<void> deleteCartItem(int productId) async {
    Database db = await instance.database;
    await db.delete(
      'cart',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
  }

  // Новый метод для очистки всех элементов в корзине
  Future<void> clearCartItems() async {
    Database db = await instance.database;
    await db.delete('cart');
  }
}
