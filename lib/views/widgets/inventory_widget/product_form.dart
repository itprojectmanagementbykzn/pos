import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_system/controller/inventory_controller.dart';

class ProductFormWidget extends StatelessWidget {
  const ProductFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InventoryController _inController = Get.find();
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.3,
      child: Column(
        children: [
          TextFormField(
            controller: _inController.nameController,
            maxLines: 1,
            decoration: const InputDecoration(hintText: "Product Name"),
          ),
          TextFormField(
            controller: _inController.originalPriceController,
            maxLines: 1,
            decoration: const InputDecoration(hintText: "Original Price"),
          ),
          TextFormField(
            controller: _inController.priceController,
            maxLines: 1,
            decoration: const InputDecoration(hintText: "Price"),
          ),
          TextFormField(
            controller: _inController.quantityController,
            maxLines: 1,
            decoration: const InputDecoration(hintText: "Quantity"),
          ),
        ],
      ),
    );
  }
}
