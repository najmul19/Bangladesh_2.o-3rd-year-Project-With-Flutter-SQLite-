import 'package:bangladesh_2o/AdminPanel/view_shop_products.dart';
import 'package:bangladesh_2o/login_page.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'admin_page.dart'; // Add Product Page
import 'admin_page_add_shop.dart';
import 'se_products_admin.dart'; // View Products Page

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color(0xffecefe8),
      appBar: AppBar(
        backgroundColor: const Color(0xffecefe8),
        centerTitle: true,
        title: "Home Admin".text.xl3.bold.black.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildMenuTile(
              context,
              "Add Items",
              Icons.add_box_outlined,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminPage()),
              ),
            ),
            const SizedBox(height: 50),
            _buildMenuTile(
              context,
              "Add Products",
              Icons.add_box_outlined,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProductShop()),
              ),
            ),
            const SizedBox(height: 50),
            _buildMenuTile(
              context,
              "View Items",
              Icons.view_list,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewProductsPage()),
              ),
            ),
            const SizedBox(height: 50),
            _buildMenuTile(
              context,
              "View Products",
              Icons.view_list,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ViewProductsShop()),
              ),
            ),
            const SizedBox(height: 50),
            _buildMenuTile(
              context,
              "Log Out",
              Icons.logout_outlined,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 50),
                const SizedBox(width: 20),
                title.text.xl3.bold.black.make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
