
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static const String dbName = "categories.db";
  static const String tableName = "items";

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
  String path = join(await getDatabasesPath(), dbName);
  return openDatabase(
    path,
    version: 3, // Incremented version
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category TEXT,
          name TEXT,
          image TEXT,
          description TEXT,
          phone TEXT
        )
      ''');
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 3) {
        await db.execute('ALTER TABLE $tableName ADD COLUMN phone TEXT');
      }
    },
  );
}

static Future<void> insertItem(
  String category,
  String name,
  String imagePath,
  String description,
  {String? phone}
) async {
  final db = await DBHelper.db;
  await db.insert(
    tableName,
    {
      'category': category,
      'name': name,
      'image': imagePath,
      'description': description,
      'phone': phone, // Add phone to the data map
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

static Future<int> updateItem(
  int id,
  String category,
  String name,
  String imagePath,
  String description,
  {String? phone}
) async {
  final db = await DBHelper.db;
  return await db.update(
    tableName,
    {
      'category': category,
      'name': name,
      'image': imagePath,
      'description': description,
      'phone': phone, // Include phone
    },
    where: "id = ?",
    whereArgs: [id],
  );
}



// static Future<Database> _initDB() async {
//   String path = join(await getDatabasesPath(), dbName);
//   return openDatabase(
//     path,
//     version: 2,
//     onCreate: (db, version) async {
//       await db.execute('''
//         CREATE TABLE $tableName (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           category TEXT,
//           name TEXT,
//           image TEXT,
//           description TEXT
//         )
//       ''');
    
//     },
//     onUpgrade: (db, oldVersion, newVersion) async {
//       // Handle upgrades
//       if (oldVersion < 2) {
//         await db.execute('''
//           CREATE TABLE IF NOT EXISTS orders (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             user_email TEXT,
//             product_id INTEGER,
//             quantity INTEGER,
//             total_price REAL
//           )
//         ''');
//       }
//     },
//   );
// }

// static Future<void> insertItem(String category, String name, String imagePath, String description) async {
//   final db = await DBHelper.db;
//   print("Inserting imagePath: $imagePath"); // Debug
//   await db.insert(
//     tableName,
//     {
//       'category': category,
//       'name': name,
//       'image': imagePath,
//       'description': description,
//     },
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }

  static Future<List<Map<String, dynamic>>> fetchItems(String category) async {
    final db = await DBHelper.db;
    return await db.query(tableName, where: "category = ?", whereArgs: [category]);
  }

  static Future<int> deleteItem(int id) async {
    final db = await DBHelper.db;
    return await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  //------------------------------updated
  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await DBHelper.db;
    return db.query('categories');
  }

  Future<void> deleteCategory(int id) async {
    final db = await DBHelper.db;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    final db = await DBHelper.db;
    return db.query('orders');
  }


//   static Future<int> updateItem(int id, String category, String name, String imagePath, String description) async {
//   final db = await DBHelper.db;
//   return await db.update(
//     tableName,
//     {
//       'category': category,
//       'name': name,
//       'image': imagePath,
//       'description': description,
//     },
//     where: "id = ?",
//     whereArgs: [id],
//   );
// }


 
}
