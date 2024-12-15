// import 'package:flutter/material.dart';
// import 'package:bangladesh_2o/DB/DbHelper_Shop.dart';

// class OrdersPage extends StatelessWidget {
//   final dbHelper = DBHelper_Shop();
//   final int userId = 1; // Replace with dynamic user ID if needed.

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Orders"),
//         backgroundColor: Colors.teal,
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>( // Fetch orders for the user
//         future: dbHelper.fetchOrdersByUser(userId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
//             return const Center(child: Text("No orders found."));
//           } else {
//             final orders = snapshot.data!;
//             return ListView.builder(
//               padding: const EdgeInsets.all(8.0),
//               itemCount: orders.length,
//               itemBuilder: (context, index) {
//                 final order = orders[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: ListTile(
//                     title: Text("Order #${order['order_id']}"),
//                     subtitle: Text("Total: \$${order['total_price']}"),
//                     trailing: Text(order['order_date']),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:bangladesh_2o/DB/DbHelper_Shop.dart';

class OrdersPage extends StatelessWidget {
  final dbHelper = DBHelper_Shop();
  final int userId = 1; // Replace with dynamic user ID if needed.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.fetchOrdersByUser(userId), // Fetch orders for the user
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text("No orders found."));
          } else {
            final orders = snapshot.data!;
           return ListView.builder(
  padding: const EdgeInsets.all(8.0),
  itemCount: orders.length,
  itemBuilder: (context, index) {
    final order = orders[index];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        title: Text(
          "Order #${order['order_id']} - ${order['product_name'] ?? 'Unknown Product'}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quantity: ${order['quantity']}"),
            Text("Total Price: \$${order['total_price']}"),
            Text("Date: ${order['order_date']}"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _deleteOrder(context, order['order_id']);
          },
        ),
      ),
    );
  },
);

          }
        },
      ),
    );
  }

  void _deleteOrder(BuildContext context, int orderId) async {
    // Confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Order"),
          content: const Text("Are you sure you want to delete this order?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await dbHelper.deleteOrder(orderId); // Delete order from database
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order deleted successfully!")),
      );

      // Refresh the screen after deletion
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OrdersPage()),
      );
    }
  }
}
