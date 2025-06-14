import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_place.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database?_database;
  DatabaseHelper._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  Future<Database> _initDatabase() async {
    String path = '';
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      path = 'my_web_database.db';
    } else {
      path = join(await getDatabasesPath(), 'places_database.db');
    }
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE userplaces (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    placeName TEXT,
    latitude REAL,
    longitude REAL,
    address TEXT,
    imagePath TEXT
    )
    ''');
  }
  Future<int> insertPlace(UserPlace userPlace) async {
    final db = await database;
    return await db.insert(
        'userplaces',
        userPlace.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
  Future<List<UserPlace>> getAllPlaces() async {
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query('userplaces');
    return List.generate(maps.length,(index){
      return UserPlace.fromMap(maps[index]);
    });
  }
  Future<int> deletePlace(int id) async {
    final db = await database;
    return await db.delete(
        'userplaces',
        where: 'id = ?',
        whereArgs: [id]
    );
  }
}