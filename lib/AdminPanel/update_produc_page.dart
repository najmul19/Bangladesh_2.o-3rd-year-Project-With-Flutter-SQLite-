import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../DB/DBHelper.dart';

class UpdateProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const UpdateProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _phoneController;
  late String _selectedCategory;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product['name']);
    _descriptionController =
        TextEditingController(text: widget.product['description']);
    _phoneController = TextEditingController(text: widget.product['phone']);
    _selectedCategory = widget.product['category'];
    _selectedImage =
        widget.product['image'] != null ? File(widget.product['image']) : null;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _updateItem() async {
    String name = _nameController.text;
    String description = _descriptionController.text;
    String? phone =
        _phoneController.text.isNotEmpty ? _phoneController.text : null;

    // Display a warning if phone is not provided but it's optional
    if ((_selectedCategory == "Martyrs" || _selectedCategory == "Injured") &&
        (phone == null || phone.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Phone number is optional. Leave it blank if not needed.")),
      );
    }

    await DBHelper.updateItem(
      widget.product['id'],
      _selectedCategory,
      name,
      _selectedImage?.path ??
          widget.product['image'], // Keep old image if none selected
      description,
      phone: phone,
    );
    Navigator.pop(context, true); // Return true to indicate success
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
              // Only show phone number field if the category is Martyrs or Injured
              // if (_selectedCategory == "Martyrs" ||
              //     _selectedCategory == "Injured")
              //   TextField(
              //     controller: _phoneController,
              //     decoration: InputDecoration(
              //       labelText: "Phone Number (required for Martyrs/Injured)",
              //       hintText: "Required for Martyrs/Injured",
              //     ),
              //     keyboardType: TextInputType.phone,
              //   ),
              if (_selectedCategory == "Martyrs" ||
                  _selectedCategory == "Injured")
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: "Phone Number (optional for Martyrs/Injured)",
                    hintText: "You can leave this blank if not needed",
                  ),
                  keyboardType: TextInputType.phone,
                ),

              const SizedBox(height: 10),

              _selectedImage == null
                  ? const Text("No image selected")
                  : Image.file(
                      _selectedImage!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Select Image from Gallery"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateItem,
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
