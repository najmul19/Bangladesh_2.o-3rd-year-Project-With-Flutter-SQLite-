import 'dart:io';
import 'package:flutter/material.dart';
import '../DB/DBHelper.dart';

import 'update_produc_page.dart'; // Import the update page

class ViewProductsPage extends StatefulWidget {
  const ViewProductsPage({Key? key}) : super(key: key);

  @override
  _ViewProductsPageState createState() => _ViewProductsPageState();
}

class _ViewProductsPageState extends State<ViewProductsPage> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  /// Fetch all products from the database
  Future<void> _fetchProducts() async {
    try {
      final db = await DBHelper.db;
      final data = await db.query(DBHelper.tableName); // Fetch all products
      setState(() {
        _items = data;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching items: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Delete a product by ID
  Future<void> _deleteProduct(int id) async {
    try {
      await DBHelper.deleteItem(id);
      _fetchProducts(); // Refresh the list after deletion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Item deleted successfully")),
      );
    } catch (e) {
      print("Error deleting items: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete Item")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffecefe8),
      appBar: AppBar(
        backgroundColor: const Color(0xffecefe8),
        title: const Text('View Items'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _items.isEmpty
              ? const Center(
                  child: Text("No products found"),
                )
              : ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final product = _items[index];
                    return Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        // contentPadding: const EdgeInsets.all(8.0),
                        leading: product['image'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(product['image']),
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.image, size: 50),
                        title: Text(
                          product['name'] ?? "Unknown Product",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['description'] ?? "No description",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                            if (product['phone'] != null &&
                                product['phone'].isNotEmpty)
                              Text(
                                "Phone: ${product['phone']}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.blue),
                              ),
                            Text(
                              "Category: ${product['category'] ?? 'Uncategorized'}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                final updated = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProductPage(
                                      product: product,
                                    ),
                                  ),
                                );
                                if (updated == true) {
                                  _fetchProducts();
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _showDeleteConfirmation(product['id']);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  /// Show a confirmation dialog before deleting
  void _showDeleteConfirmation(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Confirmation"),
        content: const Text("Are you sure you want to delete this product?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _deleteProduct(id);
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
