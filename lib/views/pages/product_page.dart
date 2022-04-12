import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_system/controller/all_controller.dart';
import 'package:pos_system/model/order_data.dart';
import 'package:pos_system/utils/theme.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllController _controller = Get.find();
    final size = MediaQuery.of(context).size;
    return Obx(() {
      if (_controller.productList.isEmpty) {
        return const Center(child: Text("No Products"));
      } else {
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: GridView.builder(
            itemCount: _controller.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final product = _controller.productList[index];
              return SizedBox(
                height: 150,
                child: Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      //Product Name
                      Text(
                        product.name,
                        style: header1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      //Product Price
                      Text(
                        "${product.price}ks",
                        style: header2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //Count
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                _controller.subtration(product);
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text("${product.count}"),
                            IconButton(
                              onPressed: () {
                                _controller.addition(product);
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      //OrderNowButton
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: orderNowColor,
                        ),
                        onPressed: () => _controller.uploadOrder(
                          OrderData(
                            id: product.id,
                            name: product.name,
                            count: product.count!,
                          ),
                          product,
                        ),
                        child: const Text("Order Now", style: buttonText),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }
}
