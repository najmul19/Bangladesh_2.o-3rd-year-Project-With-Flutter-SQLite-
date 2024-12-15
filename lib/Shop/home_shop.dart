import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'catagory_products.dart';

class Home_Shop extends StatefulWidget {
  final String name;
  final String image;

  const Home_Shop({required this.name, required this.image, super.key});

  @override
  State<Home_Shop> createState() => _Home_ShopState();
}

class _Home_ShopState extends State<Home_Shop> {
  List catgories = [
    "assets/images/t_shirt.jpeg",
    "assets/images/shirt.jpeg",
    "assets/images/pant.jpg",
    "assets/images/hoodie.jpeg",
  ];

  List catagoryName = [
    "TShirt",
    "Shirt",
    'Pant',
    'Hoddie',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          automaticallyImplyLeading: false,
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
      backgroundColor: const Color(0xffecefe8),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Catagories".text.black.xl2.bold.make(),
                  "See all".text.red600.xl.bold.make(),
                ],
              ),
              20.heightBox,
              Row(
                children: [
                  Container(
                    height: 120,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: "All".text.white.xl.bold.make()),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 120,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: catgories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CatagoryTile(
                              image: catgories[index],
                              name: catagoryName[index],
                            );
                          }),
                    ),
                  ),
                ],
              ),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}

class CatagoryTile extends StatelessWidget {
  final String image, name;
  const CatagoryTile({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryProducts(category: name)));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 90,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
