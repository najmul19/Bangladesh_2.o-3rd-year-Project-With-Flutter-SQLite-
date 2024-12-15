import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'details_page.dart'; // Import the DetailsPage

class SeeAllPage extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> items;

  const SeeAllPage({required this.category, required this.items, Key? key})
      : super(key: key);

  Future<void> _makePhoneCall(String? phoneNumber, BuildContext context) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      _showSnackBar(context, 'Number not exist');
      return;
    }
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      debugPrint('Error launching CALL URI: $e');
      _showSnackBar(context, 'Unable to make the call');
    }
  }

  Future<void> _sendSms(String? phoneNumber, BuildContext context) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      _showSnackBar(context, 'Number not exist');
      return;
    }
    final Uri launchUri = Uri(scheme: 'sms', path: phoneNumber);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      debugPrint('Error launching SMS URI: $e');
      _showSnackBar(context, 'Unable to send message');
    }
  }

  // Function to show SnackBar with message
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.red[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffecefe8),
      appBar: AppBar(
        title: Text("All $category"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (items.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          leading: item['image'] != null &&
                                  File(item['image']).existsSync()
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(item['image']),
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.broken_image, size: 60),
                          title: Text(
                            // item['name'].length > 15
                            //     ? '${item['name'].substring(0, 15)}...'
                            //     : item['name'],
                            item['name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            item['description'],
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: category == 'Memorise'
                              ? null
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.call,
                                          color: Colors.green),
                                      onPressed: () => _makePhoneCall(
                                          item['phone'], context),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.message,
                                          color: Colors.blue),
                                      onPressed: () =>
                                          _sendSms(item['phone'], context),
                                    ),
                                  ],
                                ),
                          onTap: () {
                            // Navigate to DetailsPage and pass data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  name: item['name'],
                                  imagePath: item['image'],
                                  description: item['description'],
                                  phone: item['phone'],
                                  category: category,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                )
              else
                const Center(
                  child: Text(
                    "No items available",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
