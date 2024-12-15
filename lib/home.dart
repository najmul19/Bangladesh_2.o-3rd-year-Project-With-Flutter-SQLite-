//-------------------------------------------------------------------
import 'dart:io';

import 'package:flutter/material.dart';
import 'DB/DBHelper.dart';
import 'details_page.dart';
import 'see_all_page.dart';

class Home extends StatefulWidget {
  final String name;
  final String image;

  const Home({required this.name, required this.image, super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> memoriseItems = [];
  List<Map<String, dynamic>> martyrsItems = [];
  List<Map<String, dynamic>> injuredItems = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    memoriseItems = await DBHelper.fetchItems("Memorise");
    martyrsItems = await DBHelper.fetchItems("Martyrs");
    injuredItems = await DBHelper.fetchItems("Injured");
    print(memoriseItems); // Log the fetched data
    setState(() {});
  }

  // Widget _buildCategory(String title, List<Map<String, dynamic>> items) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //       ),
  //       SizedBox(
  //         height: 215,
  //         child: ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: items.length,
  //           itemBuilder: (context, index) {
  //             final item = items[index];
  //             return GestureDetector(
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => DetailsPage(
  //                       name: item['name'],
  //                       imagePath: item['image'],
  //                       description: item['description'],
  //                     ),
  //                   ),
  //                 );
  //               },
  //               child: Container(
  //                 margin: const EdgeInsets.only(right: 20),
  //                 padding: const EdgeInsets.all(20),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     item['image'] != null && File(item['image']).existsSync()
  //                         ? Image.file(
  //                             File(item['image']),
  //                             height: 150,
  //                             width: 150,
  //                             fit: BoxFit.cover,
  //                           )
  //                         : Icon(Icons.broken_image, size: 100),
  //                     Text(
  //                       item['name'],
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildCategory(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SeeAllPage(category: title, items: items),
                  ),
                );
              },
              child:
                  const Text("See All", style: TextStyle(color: Colors.teal)),
            ),
          ],
        ),
        SizedBox(
          height: 215,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        name: item['name'],
                        imagePath: item['image'],
                        phone: item['phone'], //new
                        description: item['description'],
                        category: item['category'],  // new
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      item['image'] != null && File(item['image']).existsSync()
                          ? Image.file(
                              File(item['image']),
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.broken_image, size: 100),
                      Text(
                        item['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffecefe8),
      // appBar: AppBar(
      //   title: Text("Home"),
      //   backgroundColor: Colors.teal,
      // ),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120), // Adjust the height
        child: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: const Color.fromARGB(255, 49, 82, 97),
          backgroundColor: Colors.teal,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hey, ${widget.name}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Welcome",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: widget.image.startsWith('http')
                          ? Image.network(
                              widget.image,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              widget.image,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Name",
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCategory("Memorise", memoriseItems),
              SizedBox(height: 20),
              _buildCategory("Martyrs", martyrsItems),
              SizedBox(height: 20),
              _buildCategory("Injured", injuredItems),
            ],
          ),
        ),
      ),
    );
  }
}
