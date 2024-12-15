import 'package:bangladesh_2o/Shop/home_shop.dart';
import 'package:bangladesh_2o/Shop/my_order_page.dart';
import 'package:bangladesh_2o/home.dart';
import 'package:bangladesh_2o/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Bottomavigation extends StatefulWidget {
  final String userName;
  final String userImage;
  final String userId;

  const Bottomavigation({
    super.key,
    required this.userName,
    required this.userImage, 
    required this.userId,
  });

  @override
  State<Bottomavigation> createState() => _BottomavigationState();
}

class _BottomavigationState extends State<Bottomavigation> {
  late List<Widget> pages;
  late Home home;
  late Home_Shop homeShop;
  //late OrderPage orderPage;
  late Profile profile;
  int currentTabIndex = 0;

  @override
  void initState() {
    home = Home(name: widget.userName, image: widget.userImage);
    homeShop = Home_Shop(name: widget.userName, image: widget.userImage);
   // orderPage = OrderPage(userId: int.parse(widget.userId)); 
    profile =
        const Profile(); // If the Profile widget needs user data, pass it here.
    pages = [home, homeShop, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: const Color(0xffecefe8),
        //color: const Color.fromARGB(255, 49, 82, 97),
        color: Colors.teal,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.shop_2_outlined),
          // Icon(Icons.card_travel),
          Icon(Icons.person_2_outlined, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
