import 'dart:async';
import 'package:sheber_market/models/cart_item.dart';
import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/models/user_address.dart';
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

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY,
        name TEXT,
        photo_url TEXT
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

  // Методы для работы с таблицей категорий
  Future<void> insertCategory(Category category) async {
    Database db = await instance.database;
    await db.insert('categories', category.toMap());
  }

  Future<List<Category>> queryAllCategories() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('categories');

    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  Future<void> deleteCategory(int id) async {
    Database db = await instance.database;
    await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Новый метод для очистки всех категорий
  Future<void> clearCategories() async {
    Database db = await instance.database;
    await db.delete('categories');
  }




  // Методы для работы с таблицей адресов
Future<void> insertUserAddress(UserAddress address) async {
  Database db = await instance.database;
  await db.insert('user_addresses', address.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<void> updateUserAddress(UserAddress address) async {
  Database db = await instance.database;
  await db.update(
    'user_addresses',
    address.toMap(),
    where: 'id = ?',
    whereArgs: [address.id],
  );
}

Future<void> deleteUserAddress(int id) async {
  Database db = await instance.database;
  await db.delete(
    'user_addresses',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> clearUserAddresses() async {
  Database db = await instance.database;
  await db.delete('user_addresses');
}

Future<List<UserAddress>> queryAllUserAddresses() async {
  Database db = await instance.database;
  final List<Map<String, dynamic>> maps = await db.query('user_addresses');

  return List.generate(maps.length, (i) {
    return UserAddress.fromMap(maps[i]);
  });
}

}
