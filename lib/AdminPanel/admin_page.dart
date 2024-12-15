// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../DB/DBHelper.dart';

// class AdminPage extends StatefulWidget {
//   @override
//   State<AdminPage> createState() => _AdminPageState();
// }

// class _AdminPageState extends State<AdminPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   String _selectedCategory = "Memorise";
//   File? _selectedImage;

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//       });
//     }
//   }

//   void _addItem() async {
//     String name = _nameController.text;
//     String description = _descriptionController.text;

//     if (name.isNotEmpty && _selectedImage != null && description.isNotEmpty) {
//       await DBHelper.insertItem(
//         _selectedCategory,
//         name,
//         _selectedImage!.path, // Save image path to the database
//         description,
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Item Added!")),
//       );
//       _nameController.clear();
//       _descriptionController.clear();
//       setState(() {
//         _selectedImage = null;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please fill all fields and select an image!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Admin Panel"),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               DropdownButton<String>(
//                 value: _selectedCategory,
//                 items: ["Memorise", "Martyrs", "Injured"]
//                     .map((category) => DropdownMenuItem(
//                           value: category,
//                           child: Text(category),
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedCategory = value!;
//                   });
//                 },
//               ),
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: "Name"),
//               ),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: "Description"),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 10),
//               _selectedImage == null
//                   ? const Text("No image selected")
//                   : Image.file(
//                       _selectedImage!,
//                       height: 100,
//                       width: 100,
//                       fit: BoxFit.cover,
//                     ),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text("Select Image from Gallery"),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _addItem,
//                 child: Text("Add Item"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../DB/DBHelper.dart';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCategory = "Memorise";
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _addItem() async {
    String name = _nameController.text;
    String description = _descriptionController.text;
    String? phone =
        _phoneController.text.isNotEmpty ? _phoneController.text : null;

    // Check if category is not "Martyrs" or "Injured" and phone number is empty
    if (name.isNotEmpty && _selectedImage != null && description.isNotEmpty) {

      // Insert item into database
      await DBHelper.insertItem(
        _selectedCategory,
        name,
        _selectedImage!.path,
        description,
        phone: phone, // Insert phone number if it's not null
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Item Added!")),
      );

      // Clear fields after insertion
      _nameController.clear();
      _descriptionController.clear();
      _phoneController.clear();
      setState(() {
        _selectedImage = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Please fill all required fields and select an image!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Dropdown to select category
              DropdownButton<String>(
                value: _selectedCategory,
                items: ["Memorise", "Martyrs", "Injured"]
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              // Name field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              // Description field
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
              // Phone field, shown only for "Injured" or "Martyrs"
              if (_selectedCategory == "Injured" ||
                  _selectedCategory == "Martyrs")
                TextField(
                  controller: _phoneController,
                  decoration:
                      InputDecoration(labelText: "Phone Number (Optional)"),
                  keyboardType: TextInputType.phone,
                ),
              const SizedBox(height: 10),
              // Image preview
              _selectedImage == null
                  ? const Text("No image selected")
                  : Image.file(
                      _selectedImage!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
              // Button to select image
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Select Image from Gallery"),
              ),
              SizedBox(height: 20),
              // Button to add the item
              ElevatedButton(
                onPressed: _addItem,
                child: Text("Add Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
