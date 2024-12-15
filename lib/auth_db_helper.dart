import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthDBHelper {
  static final AuthDBHelper _instance = AuthDBHelper._internal();
  Database? _database;

  AuthDBHelper._internal();

  factory AuthDBHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'auth.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            email TEXT UNIQUE NOT NULL,
            password TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> registerUser(String username, String email, String password) async {
    final db = await database;
    final hashedPassword = _hashPassword(password);
    return await db.insert(
      'users',
      {'username': username, 'email': email, 'password': hashedPassword},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // Future<Map<String, dynamic>?> loginUser(String email, String password) async {
  //   final db = await database;
  //   final hashedPassword = _hashPassword(password);
  //   final result = await db.query(
  //     'users',
  //     where: 'email = ? AND password = ?',
  //     whereArgs: [email, hashedPassword],
  //   );
  //   return result.isNotEmpty ? result.first : null;
  // }

Future<Map<String, dynamic>?> loginUser(String email, String password) async {
  final db = await database;
  final hashedPassword = _hashPassword(password);
  final result = await db.query(
    'users',
    where: 'email = ? AND password = ?',
    whereArgs: [email, hashedPassword],
  );

  // Check if result is not empty and include 'id' (userId) in the result
  if (result.isNotEmpty) {
    final user = result.first;
    return {
      'userId': user['id'],  // Add userId field
      'username': user['username'],
      'email': user['email'],
      'password': user['password'],  // You can omit password here if not needed
    };
  } else {
    return null;
  }
}

  Future<bool> resetPassword(String email, String newPassword) async {
    final db = await database;
    final hashedPassword = _hashPassword(newPassword);
    final result = await db.update(
      'users',
      {'password': hashedPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
    return result > 0;
  }

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}
