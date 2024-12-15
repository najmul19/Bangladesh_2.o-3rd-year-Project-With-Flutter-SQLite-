import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  final String name;
  final String imagePath;
  final String description;
  final String? phone;
  final String category;

  const DetailsPage({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.description,
    this.phone, // Make phone optional
    required this.category,
  }) : super(key: key);

  // Function to make a phone call
  Future<void> _makePhoneCall(String? phoneNumber, BuildContext context) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      _showSnackBar(context, 'Phone number not available');
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

  // Function to send an SMS
  Future<void> _sendSms(String? phoneNumber, BuildContext context) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      _showSnackBar(context, 'Phone number not available');
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
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Display image if it exists
            imagePath.isNotEmpty && File(imagePath).existsSync()
                ? Image.file(
                    File(imagePath),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.broken_image, size: 100),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Column for Name and Phone Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    // Use a Container to constrain the Text widget and handle overflow
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width -
                              130), // Adjust maxWidth to fit within available space
                      child: Text(
                        name,
                        overflow: TextOverflow
                            .ellipsis, // Handle overflow by ellipsis
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    if (phone != null && phone!.isNotEmpty) ...[
                      // Display phone number if it exists
                      Text(
                        'Phone number: $phone',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else ...[
                      // Display message if no phone number
                      Text(
                        'No phone number available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
                // Display phone icons if phone number is available
                if (phone != null && phone!.isNotEmpty) ...[
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.green),
                        onPressed: () => _makePhoneCall(phone, context),
                      ),
                      IconButton(
                        icon: const Icon(Icons.message, color: Colors.blue),
                        onPressed: () => _sendSms(phone, context),
                      ),
                    ],
                  ),
                ]
              ],
            ),

            const SizedBox(height: 20),

            // Description with improved text styling
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
