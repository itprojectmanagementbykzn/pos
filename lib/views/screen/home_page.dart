import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_system/controller/all_controller.dart';
import 'package:pos_system/utils/theme.dart';
import 'package:pos_system/views/pages/admin_page.dart';
import 'package:pos_system/views/pages/product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllController _controller = Get.find();
    const List<Widget> pages = [ProductPage(), AdminPage()];
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("SHOP MANAGEMENT (POS)",
          style: TextStyle(color: Colors.black,
          fontSize: 15,
          letterSpacing: 1,
          wordSpacing: 1),),
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(() => pages.elementAt(_controller.currentNavIndex.value)),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          selectedItemColor: Colours.red,
          currentIndex: _controller.currentNavIndex.value,
          onTap: _controller.changeCurrentNavIndex,
          items: const <BottomNavigationBarItem>[
            //Product Page
            BottomNavigationBarItem(
              icon: Icon(Icons.store_mall_directory),
              label: "POS",
            ),
            //Admin Page
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Management",
            ),
          ],
        );
      }),
    );
  }
}
