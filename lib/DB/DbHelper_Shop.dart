import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper_Shop {
  static final DBHelper_Shop _instance = DBHelper_Shop._internal();
  static Database? _database;

  DBHelper_Shop._internal();

  factory DBHelper_Shop() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'shop.db');
    // await deleteDatabase(path); // Uncomment this for fresh DB each time during testing

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            title TEXT NOT NULL,
            price TEXT NOT NULL,
            category TEXT NOT NULL,
            image TEXT NOT NULL,
            detail TEXT NOT NULL
          )
        ''');

        // Create orders table
        await db.execute('''
          CREATE TABLE orders(
            order_id INTEGER PRIMARY KEY AUTOINCREMENT,
            product_id INTEGER NOT NULL,
            user_id INTEGER NOT NULL,
            quantity INTEGER NOT NULL,
            total_price TEXT NOT NULL,
            order_date TEXT NOT NULL,
            FOREIGN KEY (product_id) REFERENCES products(id)
          )
        ''');

        await db.execute('''
  CREATE TABLE cart(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    total_price TEXT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
  )
''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
      CREATE TABLE orders(
        order_id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        total_price TEXT NOT NULL,
        order_date TEXT NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products(id)
      )
    ''');
        }
        if (oldVersion < 3) {
          await db.execute('''
      CREATE TABLE IF NOT EXISTS cart(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        total_price TEXT NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products(id)
      )
    ''');
        }
      },
    );
  }

  // Insert a new product into the products table
  Future<int> insertProduct(Map<String, dynamic> product) async {
    final db = await database;
    return await db.insert('products', product);
  }

  // Fetch all products from the products table
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final db = await database;
    return await db.query('products');
  }

// Insert an item into the cart with error handling
Future<int> insertCart(Map<String, dynamic> cartData) async {
  final db = await database;
  try {
    if (cartData['user_id'] == null ||
        cartData['product_id'] == null ||
        cartData['quantity'] == null ||
        cartData['total_price'] == null) {
      throw Exception("Invalid cart data: All fields must be provided.");
    }
    return await db.insert('cart', cartData);
  } catch (e) {
    print("Error inserting into cart: $e");
    throw Exception("Failed to add item to cart.");
  }
}

// Fetch cart items with error handling
Future<List<Map<String, dynamic>>> fetchCartByUser(int userId) async {
  final db = await database;
  try {
    final result = await db.query('cart', where: 'user_id = ?', whereArgs: [userId]);
    return result;
  } catch (e) {
    print("Error fetching cart: $e");
    throw Exception("Failed to fetch cart items.");
  }
}
// Fetch cart items with product details
Future<List<Map<String, dynamic>>> fetchCartWithProductDetails(int userId) async {
  final db = await database;
  final query = '''
    SELECT cart.id, cart.product_id, cart.quantity, cart.total_price, 
           products.name AS product_name
    FROM cart
    JOIN products ON cart.product_id = products.id
    WHERE cart.user_id = ?
  ''';
  return await db.rawQuery(query, [userId]);
}


// Clear cart after placing an order
  Future<int> clearCart(int userId) async {
    final db = await database;
    return await db.delete('cart', where: 'user_id = ?', whereArgs: [userId]);
  }

  // Fetch products by category
  Future<List<Map<String, dynamic>>> fetchProductsByCategory(
      String category) async {
    final db = await database;
    final result = await db
        .query('products', where: 'category = ?', whereArgs: [category]);
    return result;
  }

  // Insert an order into the orders table
  Future<int> insertOrder(Map<String, dynamic> order) async {
    final db = await database;
    return await db.insert('orders', order);
  }

  // // Fetch all orders by user ID (orders placed by a specific user)
  // Future<List<Map<String, dynamic>>> fetchOrdersByUser(int userId) async {
  //   final db = await database;
  //   final result =
  //       await db.query('orders', where: 'user_id = ?', whereArgs: [userId]);
  //   return result;
  // }
  // Fetch all orders by user ID with product details
Future<List<Map<String, dynamic>>> fetchOrdersByUser(int userId) async {
  final db = await database;
  final query = '''
    SELECT orders.order_id, orders.quantity, orders.total_price, 
           orders.order_date, products.name AS product_name
    FROM orders
    JOIN products ON orders.product_id = products.id
    WHERE orders.user_id = ?
  ''';
  return await db.rawQuery(query, [userId]);
}


  // Delete a product from the products table
  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
   // Delete an order from the orders table
  Future<int> deleteOrder(int orderId) async {
    final db = await database;
    return await db.delete('orders', where: 'order_id = ?', whereArgs: [orderId]);
  }



  // Update a product in the products table
// Future<int> updateProduct(int id, Map<String, dynamic> updatedProduct) async {
//   final db = await database;
//   return await db.update(
//     'products',
//     updatedProduct,
//     where: 'id = ?',
//     whereArgs: [id],
//   );
// }
// Update a product in the products table
Future<int> updateProduct(int id, Map<String, dynamic> updatedProduct) async {
  final db = await database;
  return await db.update(
    'products',                // Table name
    updatedProduct,            // Updated data
    where: 'id = ?',           // Condition
    whereArgs: [id],           // Arguments for the condition
  );
}






}
