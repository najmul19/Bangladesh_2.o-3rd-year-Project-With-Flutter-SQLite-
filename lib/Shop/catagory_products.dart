// // 
// import 'package:flutter/material.dart';
// import 'package:bangladesh_2o/DB/DbHelper_Shop.dart';
// import 'dart:io';
// import 'product_details.dart';
// import 'package:bangladesh_2o/Shop/my_order_page.dart';
// import 'cart_page.dart';

// class CategoryProducts extends StatelessWidget {
//   final String category;
//   final dbHelper = DBHelper_Shop();
//   final int userId = 1; // Replace with actual dynamic user ID

//   CategoryProducts({required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Category: $category"),
//         backgroundColor: Colors.teal,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.list_alt),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => OrdersPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: dbHelper.fetchProductsByCategory(category),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError ||
//               snapshot.data == null ||
//               snapshot.data!.isEmpty) {
//             return const Center(child: Text("No products found!"));
//           } else {
//             final products = snapshot.data!;
//             return ListView.builder(
//               padding: const EdgeInsets.all(8.0),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: ListTile(
//                     leading: product['image'] != null &&
//                             product['image'].isNotEmpty
//                         ? (product['image'].startsWith('http')
//                             ? Image.network(product['image'],
//                                 width: 50, height: 50, fit: BoxFit.cover)
//                             : Image.file(File(product['image']),
//                                 width: 50, height: 50, fit: BoxFit.cover))
//                         : const Icon(Icons.image, size: 50, color: Colors.grey),
//                     title: Text(product['name']),
//                     subtitle: Text("\$${product['price']}"),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ProductDetail(
//                             image: product['image'],
//                             name: product['name'],
//                             title: product["title"] ?? '',
//                             detail: product['detail'] ?? '',
//                             price: product['price'],
//                             category: product["category"],
//                           ),
//                         ),
//                       );
//                     },
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.add_shopping_cart),
//                           onPressed: () async {
//                             try {
//                               final cartData = {
//                                 'user_id': userId,
//                                 'product_id': product['id'],
//                                 'quantity': 1,
//                                 'total_price': product['price'],
//                               };
//                               await dbHelper.insertCart(cartData);
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text('Added to Cart!')),
//                               );
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text('Error: ${e.toString()}')),
//                               );
//                             }
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.add),
//                           onPressed: () async {
//                             try {
//                               final orderData = {
//                                 'user_id': userId,
//                                 'product_id': product['id'],
//                                 'quantity': 1,
//                                 'total_price': product['price'],
//                                 'order_date': DateTime.now().toString(),
//                               };
//                               await dbHelper.insertOrder(orderData);
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content:
//                                         Text('Order placed successfully!')),
//                               );
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text('Error: ${e.toString()}')),
//                               );
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CartPage()),
//           );
//         },
//         child: const Icon(Icons.shopping_cart),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:bangladesh_2o/DB/DbHelper_Shop.dart';
import 'dart:io';
import 'product_details.dart';
import 'package:bangladesh_2o/Shop/my_order_page.dart';
import 'cart_page.dart';

class CategoryProducts extends StatelessWidget {
  final String category;
  final dbHelper = DBHelper_Shop();
  final int userId = 1; // Replace with actual dynamic user ID

  CategoryProducts({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category: $category"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdersPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.fetchProductsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products found!"));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: _buildProductImage(product['image']),
                    title: Text(product['name']),
                    subtitle: Text("\$${product['price']}"),
                    onTap: () => _navigateToProductDetail(context, product),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () => _addToCart(context, product),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _placeOrder(context, product),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _buildProductImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return imagePath.startsWith('http')
          ? Image.network(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(imagePath),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            );
    }
    return const Icon(Icons.image, size: 50, color: Colors.grey);
  }

  void _navigateToProductDetail(BuildContext context, Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetail(
          productId: product['id'],
          image: product['image'],
          name: product['name'],
          title: product["title"] ?? '',
          detail: product['detail'] ?? '',
          price: product['price'],
          category: product["category"],
        ),
      ),
    );
  }

  Future<void> _addToCart(BuildContext context, Map<String, dynamic> product) async {
    try {
      final cartData = {
        'user_id': userId,
        'product_id': product['id'],
        'quantity': 1,
        'total_price': product['price'],
      };
      await dbHelper.insertCart(cartData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to Cart!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding to cart: ${e.toString()}')),
      );
    }
  }

  Future<void> _placeOrder(BuildContext context, Map<String, dynamic> product) async {
    try {
      final orderData = {
        'user_id': userId,
        'product_id': product['id'],
        'quantity': 1,
        'total_price': product['price'],
        'order_date': DateTime.now().toString(),
      };
      await dbHelper.insertOrder(orderData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error placing order: ${e.toString()}')),
      );
    }
  }
}
