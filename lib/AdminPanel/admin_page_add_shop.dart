import 'dart:io';
import 'package:bangladesh_2o/DB/DbHelper_Shop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

// class AddProductShop extends StatefulWidget {
//   const AddProductShop({super.key});

//   @override
//   State<AddProductShop> createState() => _AddProductShopState();
// }

// class _AddProductShopState extends State<AddProductShop> {
//   String? value;
//   final ImagePicker _picker = ImagePicker();
//   File? selectedImage;
//   TextEditingController nameController = new TextEditingController();
//   TextEditingController titleController = new TextEditingController();
//   TextEditingController priceController = new TextEditingController();
//   TextEditingController detailController = new TextEditingController();
//   Future getImage() async {
//     var image = await _picker.pickImage(source: ImageSource.gallery);
//     selectedImage = File(image!.path);
//     setState(() {});
//   }

//   //sqlite=================================================

//  uploadItem() async {
//   if (selectedImage != null &&
//       nameController.text.isNotEmpty &&
//       titleController.text.isNotEmpty &&
//       priceController.text.isNotEmpty &&
//       detailController.text.isNotEmpty) {
//     String imagePath = selectedImage!.path; // Store file path

//     Map<String, dynamic> addProduct = {
//       "name": nameController.text,
//       "title": titleController.text, // Ensure title is added
//       "image": imagePath,
//       "price": priceController.text,
//       "detail": detailController.text,
//       "category": value ?? '',
//     };

//     await DBHelper_Shop().insertProduct(addProduct);

//     // Clear form fields and reset state
//     selectedImage = null;
//     nameController.clear();
//     titleController.clear();
//     priceController.clear();
//     detailController.clear();
//     value = null;

//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       backgroundColor: Colors.green,
//       content: "Product has been added successfully!".text.make(),
//     ));
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       backgroundColor: Colors.red,
//       content: "All fields are required, including Title!".text.make(),
//     ));
//   }
// }

//   final List<String> catagoryItems = ['t_shirt', 'shirt', 'pant', 'hoodie'];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.arrow_back_ios_new_outlined)),
//         centerTitle: true,
//         title: "Add Product".text.bold.xl.make(),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               "Upload the Product Image".text.gray500.xl.make(),
//               20.heightBox,
//               selectedImage == null
//                   ? InkWell(
//                       onTap: () {
//                         getImage();
//                       },
//                       child: Center(
//                         child: Container(
//                           height: 150,
//                           width: 150,
//                           decoration: BoxDecoration(
//                               border:
//                                   Border.all(color: Colors.black, width: 1.5),
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Icon(Icons.camera_alt_outlined),
//                         ),
//                       ),
//                     )
//                   : Center(
//                       child: Material(
//                         elevation: 4,
//                         borderRadius: BorderRadius.circular(20),
//                         child: Container(
//                           height: 150,
//                           width: 150,
//                           decoration: BoxDecoration(
//                               border:
//                                   Border.all(color: Colors.black, width: 1.5),
//                               borderRadius: BorderRadius.circular(20)),
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(18),
//                               child: Image.file(
//                                 selectedImage!,
//                                 fit: BoxFit.cover,
//                               )),
//                         ),
//                       ),
//                     ),
//               20.heightBox,
//               "Product Name".text.xl.gray500.make(),
//               20.heightBox,
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     color: Color(0xFFececf8),
//                     borderRadius: BorderRadius.circular(18)),
//                 child: TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(border: InputBorder.none),
//                 ),
//               ),
//               20.heightBox,
//               "Product Title".text.xl.gray500.make(),
//               20.heightBox,
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     color: Color(0xFFececf8),
//                     borderRadius: BorderRadius.circular(18)),
//                 child: TextField(
//                   controller: titleController,
//                   decoration: InputDecoration(border: InputBorder.none),
//                 ),
//               ),
//               20.heightBox,
//               "Product Price".text.xl.gray500.make(),
//               20.heightBox,
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     color: Color(0xFFececf8),
//                     borderRadius: BorderRadius.circular(18)),
//                 child: TextField(
//                   controller: priceController,
//                   decoration: InputDecoration(border: InputBorder.none),
//                 ),
//               ),
//               20.heightBox,
//               "Product Details".text.xl.gray500.make(),
//               20.heightBox,
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     color: Color(0xFFececf8),
//                     borderRadius: BorderRadius.circular(18)),
//                 child: TextField(
//                   maxLines: 6,
//                   controller: detailController,
//                   decoration: InputDecoration(border: InputBorder.none),
//                 ),
//               ),
//               20.heightBox,
//               "Product Catagory".text.xl.gray500.make(),
//               20.heightBox,
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     color: Color(0xFFececf8),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     items: catagoryItems
//                         .map((item) => DropdownMenuItem(
//                             value: item,
//                             child: Text(
//                               item,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18),
//                             )))
//                         .toList(),
//                     onChanged: (value) => setState(() {
//                       this.value = value;
//                     }),
//                     dropdownColor: Colors.white,
//                     hint: "Select Catagory".text.make(),
//                     iconSize: 36,
//                     icon: Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.black,
//                     ),
//                     value: value,
//                   ),
//                 ),
//               ),
//               30.heightBox,
//               ElevatedButton(
//                 onPressed: () {
//                   uploadItem();
//                 },
//                 child: Center(child: "Add Product".text.xl2.make()),
//               )
//             ],
          
          
//           ),
//         ),
//       ),
//     );
//   }
// }
class AddProductShop extends StatefulWidget {
  const AddProductShop({super.key});

  @override
  State<AddProductShop> createState() => _AddProductShopState();
}

class _AddProductShopState extends State<AddProductShop> {
  String? value;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  uploadItem() async {
    if (selectedImage != null &&
        nameController.text.isNotEmpty &&
        titleController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        detailController.text.isNotEmpty &&
        value != null) {
      String imagePath = selectedImage!.path;

      Map<String, dynamic> addProduct = {
        "name": nameController.text,
        "title": titleController.text,
        "image": imagePath,
        "price": priceController.text,
        "detail": detailController.text,
        "category": value!,
      };

      await DBHelper_Shop().insertProduct(addProduct);

      selectedImage = null;
      nameController.clear();
      titleController.clear();
      priceController.clear();
      detailController.clear();
      value = null;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: "Product has been added successfully!".text.make(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: "All fields, including Category, are required!".text.make(),
      ));
    }
  }

  // final List<String> catagoryItems = ['t_shirt', 'shirt', 'pant', 'hoodie'];
  final List<String> catagoryItems = ['TShirt', 'Shirt', 'Pant', 'Hoddie'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
        title: "Add Product".text.bold.xl.make(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              "Upload the Product Image".text.gray500.xl.make(),
              20.heightBox,
              selectedImage == null
                  ? InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
              20.heightBox,
              "Product Name".text.xl.gray500.make(),
              20.heightBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(18)),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              20.heightBox,
              "Product Title".text.xl.gray500.make(),
              20.heightBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(18)),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              20.heightBox,
              "Product Price".text.xl.gray500.make(),
              20.heightBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(18)),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              20.heightBox,
              "Product Details".text.xl.gray500.make(),
              20.heightBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(18)),
                child: TextField(
                  maxLines: 6,
                  controller: detailController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              20.heightBox,
              "Product Catagory".text.xl.gray500.make(),
              20.heightBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: catagoryItems
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )))
                        .toList(),
                    onChanged: (value) => setState(() {
                      this.value = value;
                    }),
                    dropdownColor: Colors.white,
                    hint: "Select Catagory".text.make(),
                    iconSize: 36,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
               
                ),
              ),
              30.heightBox,
              ElevatedButton(
                onPressed: () {
                  uploadItem();
                },
                child: Center(child: "Add Product".text.xl2.make()),
              )
            ],
          
          ),
        ),
      ),
    );
  }
}
