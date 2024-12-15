import 'package:flutter/material.dart';
import 'package:bangladesh_2o/DB/DbHelper_Shop.dart';

class CartPage extends StatelessWidget {
  final dbHelper = DBHelper_Shop();
  final int userId = 1; // Replace with actual dynamic user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.fetchCartWithProductDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Your cart is empty."));
          } else {
            final cartItems = snapshot.data!;
            // Calculate total price
            final totalPrice = cartItems.fold<double>(
              0,
              (sum, item) => sum + double.tryParse(item['total_price'])!,
            );

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        title: Text('Product: ${item['product_name']}'),
                        subtitle: Text(
                          'Quantity: ${item['quantity']}, Total: \$${item['total_price']}',
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            for (var item in cartItems) {
                              final orderData = {
                                'user_id': userId,
                                'product_id': item['product_id'],
                                'quantity': item['quantity'],
                                'total_price': item['total_price'],
                                'order_date': DateTime.now().toString(),
                              };
                              await dbHelper.insertOrder(orderData);
                            }
                            await dbHelper.clearCart(userId);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Order placed successfully!')),
                            );
                            Navigator.pop(context); // Go back after placing the order
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error placing order: $e')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "Place Order",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
