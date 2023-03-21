import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesDb {
  static FavoritesDb? _databaseHelper;
  static Database? _database;

  FavoritesDb._internal() {
    _databaseHelper = this;
  }

  factory FavoritesDb() => _databaseHelper ?? FavoritesDb._internal();

  static const String _tblFavorites = 'favorites';

  Future<Database> _initializeDb() async {
    final path = await getDatabasesPath();
    final db = openDatabase(
      '$path/favorites.db',
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $_tblFavorites(id TEXT PRIMARY KEY, name TEXT,  description TEXT, city TEXT, pictureId TEXT, rating DOUBLE)');
      },
      version: 1,
    );
    return db;
  }

  Future<Database> get database async {
    _database ??= await _initializeDb();
    return _database!;
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(
      _tblFavorites,
      restaurant.toJson(),
    );
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(_tblFavorites);

    return result.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Restaurant?> getFavoritesById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      _tblFavorites,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Restaurant.fromJson(result.first);
    } else {
      return null;
    }
  }

  Future<void> deleteFavorites(String id) async {
    final db = await database;
    await db.delete(
      _tblFavorites,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
