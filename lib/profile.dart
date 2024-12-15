import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:velocity_x/velocity_x.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name, image, email;

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  // getSharedPref() async {
  //   image = await SharedPreferencesHelper().getUserImage();
  //   name = await SharedPreferencesHelper().getUserName();
  //   email = await SharedPreferencesHelper().getUserEmail();
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   getSharedPref();
  //   super.initState();
  // }

  // Future getImage() async {
  //   var image = await _picker.pickImage(source: ImageSource.gallery);
  //   selectedImage = File(image!.path);
  //   uploadItem();
  //   setState(() {});
  // }

  // uploadItem() async {
  //   if (selectedImage != null) {
  //     String addId = randomAlphaNumeric(10);
  //     Reference firebaseStorageRef =
  //         FirebaseStorage.instance.ref().child("allImages").child(addId);
  //     final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
  //     var DownloadTask = (await task).ref.getDownloadURL();
  //     await SharedPreferencesHelper().saveUserImage(DownloadTask as String);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffecefe8),
        centerTitle: true,
        title: "Profile".text.xl3.bold.black.make(),
      ),
      backgroundColor: Color(0xffecefe8),
      // body: name == null
      //     ? Center(child: CircularProgressIndicator())
          // : Container(
          //     child: Column(children: [
          //       selectedImage != null
          //           ? Center(
          //               child: ClipRRect(
          //                 borderRadius: BorderRadius.circular(70),
          //                 child: Image.file(
          //                   selectedImage!,
          //                   height: 90,
          //                   width: 90,
          //                   fit: BoxFit.cover,
          //                 ),
          //               ),
          //             )
          //           // : InkWell(
          //           //     onTap: () {
          //           //       getImage();
          //           //     },
          //           //     child: Center(
          //           //       child: ClipRRect(
          //           //         borderRadius: BorderRadius.circular(70),
          //           //         child: Image.network(
          //           //           image!,
          //           //           height: 90,
          //           //           width: 90,
          //           //           fit: BoxFit.cover,
          //           //         ),
          //           //       ),
          //           //     ),
          //           //   ),
               
          //       // 20.heightBox,
          //       // Container(
          //       //   margin: EdgeInsets.only(left: 20, right: 20),
          //       //   child: Material(
          //       //     borderRadius: BorderRadius.circular(10),
          //       //     elevation: 3.0,
          //       //     child: Container(
          //       //       padding: EdgeInsets.all(10),
          //       //       // padding: EdgeInsets.only(
          //       //       //     left: 10, right: 10, top: 10, bottom: 10),
          //       //       width: MediaQuery.of(context).size.width,
          //       //       decoration: BoxDecoration(
          //       //           color: Colors.white,
          //       //           borderRadius: BorderRadius.circular(20)),
          //       //       child: Row(
          //       //         children: [
          //       //           Icon(
          //       //             Icons.person_2_outlined,
          //       //             size: 35,
          //       //           ),
          //       //           10.widthBox,
          //       //           Column(
          //       //             crossAxisAlignment: CrossAxisAlignment.start,
          //       //             children: [
          //       //               "Name".text.gray600.xl2.make(),
          //       //               name!.text.black.bold.xl2.make()
          //       //             ],
          //       //           )
          //       //         ],
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //       // 20.heightBox,
          //       // Container(
          //       //   margin: EdgeInsets.only(left: 20, right: 20),
          //       //   child: Material(
          //       //     borderRadius: BorderRadius.circular(10),
          //       //     elevation: 3.0,
          //       //     child: Container(
          //       //       padding: EdgeInsets.all(10),
          //       //       // padding: EdgeInsets.only(
          //       //       //     left: 10, right: 10, top: 10, bottom: 10),
          //       //       width: MediaQuery.of(context).size.width,
          //       //       decoration: BoxDecoration(
          //       //           color: Colors.white,
          //       //           borderRadius: BorderRadius.circular(20)),
          //       //       child: Row(
          //       //         children: [
          //       //           Icon(
          //       //             Icons.mail_outline,
          //       //             size: 35,
          //       //           ),
          //       //           10.widthBox,
          //       //           Column(
          //       //             crossAxisAlignment: CrossAxisAlignment.start,
          //       //             children: [
          //       //               Column(
          //       //                 crossAxisAlignment: CrossAxisAlignment.start,
          //       //                 children: [
          //       //                   "Email".text.gray600.xl2.make(),
          //       //                   FittedBox(
          //       //                     fit: BoxFit
          //       //                         .scaleDown, // Scales text down if it's too big
          //       //                     child: email!.text.black.bold.xl3.make(),
          //       //                   )
          //       //                       .box
          //       //                       .width(250)
          //       //                       .make(), // Set max width for the email container
          //       //                 ],
          //       //               )
          //       //             ],
          //       //           )
          //       //         ],
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //       // 20.heightBox,
          //       // InkWell(
          //       //   onTap: () async {
          //       //     await Auth().signOutUser().then((value) {
          //       //       Navigator.pushReplacement(
          //       //           context,
          //       //           MaterialPageRoute(
          //       //               builder: (context) => Onboarding()));
          //       //     });
          //       //   },
          //       //   child: Container(
          //       //     margin: EdgeInsets.only(left: 20, right: 20),
          //       //     child: Material(
          //       //       borderRadius: BorderRadius.circular(10),
          //       //       elevation: 3.0,
          //       //       child: Container(
          //       //         padding: EdgeInsets.all(10),
          //       //         // padding: EdgeInsets.only(
          //       //         //     left: 10, right: 10, top: 10, bottom: 10),
          //       //         width: MediaQuery.of(context).size.width,
          //       //         decoration: BoxDecoration(
          //       //             color: Colors.white,
          //       //             borderRadius: BorderRadius.circular(20)),
          //       //         child: Row(
          //       //           children: [
          //       //             Icon(
          //       //               Icons.logout,
          //       //               size: 35,
          //       //             ),
          //       //             10.widthBox,
          //       //             "LogOut".text.bold.black.xl2.make(),
          //       //             Spacer(),
          //       //             Icon(Icons.arrow_forward_ios_outlined)
          //       //           ],
          //       //         ),
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //       // 20.heightBox,
          //       // InkWell(
          //       //   onTap: () async {
          //       //     await Auth().deleteUser().then((value) {
          //       //       Navigator.pushReplacement(
          //       //           context,
          //       //           MaterialPageRoute(
          //       //               builder: (context) => Onboarding()));
          //       //     });
          //       //   },
          //       //   child: Container(
          //       //     margin: EdgeInsets.only(left: 20, right: 20),
          //       //     child: Material(
          //       //       borderRadius: BorderRadius.circular(10),
          //       //       elevation: 3.0,
          //       //       child: Container(
          //       //         padding: EdgeInsets.all(10),
          //       //         // padding: EdgeInsets.only(
          //       //         //     left: 10, right: 10, top: 10, bottom: 10),
          //       //         width: MediaQuery.of(context).size.width,
          //       //         decoration: BoxDecoration(
          //       //             color: Colors.white,
          //       //             borderRadius: BorderRadius.circular(20)),
          //       //         child: Row(
          //       //           children: [
          //       //             Icon(
          //       //               Icons.delete_outline,
          //       //               size: 35,
          //       //             ),
          //       //             10.widthBox,
          //       //             "Delte Account".text.bold.black.xl2.make(),
          //       //             Spacer(),
          //       //             Icon(Icons.arrow_forward_ios_outlined)
          //       //           ],
          //       //         ),
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //     ]),
          //   ),
  
    );
  }
}
