
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/user_model.dart';

class DatabaseHelper {
  static Database? _database;
  Future<Database?> get db async {
    _database ??= await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'foodRecipe.db');
    Database db = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: _onConfigure,
    );
    return db;
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE Users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT,
    password TEXT,
    gender TEXT
  )
''');

    await db.execute('''
  CREATE TABLE Favorites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userId INTEGER,
    recipeId INTEGER,
    FOREIGN KEY (userId) REFERENCES Users (id) ON DELETE CASCADE
  )
''');
  }

  Future<int> insertUser(UserModel user) async {
    final dbClient = await db;
    return await dbClient!.insert('Users', user.toMap());
  }

  Future<UserModel?> checkUser(String email, String password) async {
    final dbClient = await db;
    var res = await dbClient!.query(
      'Users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (res.isNotEmpty) {
      return UserModel.fromMap(res.first);
    }
    return null;
  }

  Future<void> toggleFavorite(int userId, int recipeId) async {
    final dbClient = await db;

    var res = await dbClient!.query(
      'Favorites',
      where: 'userId = ? AND recipeId = ?',
      whereArgs: [userId, recipeId],
    );

    if (res.isEmpty) {
      await dbClient.insert('Favorites', {
        'userId': userId,
        'recipeId': recipeId,
      });
    } else {
      await dbClient.delete(
        'Favorites',
        where: 'userId = ? AND recipeId = ?',
        whereArgs: [userId, recipeId],
      );
    }
  }

  Future<List<int>> getFavoriteIds(int userId) async {
    final dbClient = await db;
    var res = await dbClient!.query(
      'Favorites',
      columns: ['recipeId'],
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return res.map((e) => e['recipeId'] as int).toList();
  }
}
