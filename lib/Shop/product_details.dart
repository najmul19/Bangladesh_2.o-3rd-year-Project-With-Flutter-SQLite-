
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bangladesh_2o/DB/DbHelper_Shop.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetail extends StatefulWidget {
  final int productId; // Pass the actual product ID
  final String image, title, name, detail, price, category;

  ProductDetail({
    required this.productId,
    required this.image,
    required this.name,
    required this.title,
    required this.detail,
    required this.price,
    required this.category,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final dbHelper = DBHelper_Shop();
  final int userId = 1; // Replace with dynamic user ID if needed.
  int quantity = 1; // Initial quantity for the order
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    totalPrice =
        double.parse(widget.price) * quantity; // Calculate initial total price
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfef5f1),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                ),
                Center(
                  child: widget.image.startsWith('http')
                      ? Image.network(widget.image, height: 400)
                      : Image.file(File(widget.image), height: 400),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${widget.price}",
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      "Details".text.bold.xl.make(),
                      const SizedBox(height: 10),
                      Text(widget.detail),
                      const SizedBox(height: 20),
                      // Quantity selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                  totalPrice =
                                      double.parse(widget.price) * quantity;
                                }
                              });
                            },
                          ),
                          Text("Quantity: $quantity",
                              style: const TextStyle(fontSize: 18)),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                                totalPrice =
                                    double.parse(widget.price) * quantity;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Add to Cart button
                      InkWell(
                        onTap: () {
                          _addToCart(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: "Add to Cart".text.white.bold.xl.make(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Place Order button
                      InkWell(
                        onTap: () {
                          _placeOrder(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: "Place Order".text.white.bold.xl.make(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart(BuildContext context) async {
    // Add to cart logic
    final cartData = {
      "product_id": widget.productId, // Use actual product ID
      "user_id": userId,
      "quantity": quantity,
      "total_price": totalPrice.toStringAsFixed(2),
    };

    await dbHelper.insertCart(cartData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product added to cart!")),
    );
  }

  void _placeOrder(BuildContext context) async {
    // Place order logic
    final orderData = {
      "product_id": widget.productId, // Use actual product ID
      "user_id": userId,
      "quantity": quantity,
      "total_price": totalPrice.toStringAsFixed(2),
      "order_date": DateTime.now().toString(),
    };

    await dbHelper.insertOrder(orderData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order placed successfully!")),
    );
  }
}
