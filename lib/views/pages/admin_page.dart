import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos_system/utils/route_url.dart';
import 'package:pos_system/views/widgets/card_row.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(children: [
      //First Row
      SizedBox(
          height: 100,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Account Settings
                  CardRow(
                    icon: FontAwesomeIcons.userCog,
                    color: Colors.red,
                    text: "Settings",
                    navigateRoute: () => Get.toNamed(salesUrl),
                  ),
                  //Sales
                  CardRow(
                    icon: FontAwesomeIcons.coins,
                    color: Colors.green,
                    text: "Sales Analysis",
                    navigateRoute: () => Get.toNamed(salesUrl),
                  ),
                ]),
          )),
      //Second Row
      SizedBox(
        height: 100,
        width: size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          //Inventory Management
          CardRow(
            icon: FontAwesomeIcons.boxes,
            color: Colors.purple,
            text: "Inventory Management",
            navigateRoute: () => Get.toNamed(inventoryUrl),
          ),
          //Management Cupon
          CardRow(
            icon: FontAwesomeIcons.microchip,
            color: Colors.blue,
            text: "Coupon Management",
            navigateRoute: () => Get.toNamed(couponUrl),
          ),
        ]),
      )
    ]));
  }
}
