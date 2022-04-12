import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_system/controller/all_controller.dart';
import 'package:pos_system/model/product.dart';
import 'package:uuid/uuid.dart';

class InventoryController extends GetxController {
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController originalPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  late AllController _controller;
  Rxn<Product?> currentProduct = Rxn<Product?>(null);
  Product? historyProduct;
  var isLoading = false.obs;

  var pieTouchIndex = -1.obs;

  var totalProduct = 0.obs;
  var remainProduct = 0.obs;

  void changeCurrentProduct(Product product) {
    currentProduct.value = product;
    codeController.text = currentProduct.value!.id;
    nameController.text = currentProduct.value!.name;
    priceController.text = "${currentProduct.value!.price}";
    originalPriceController.text = "${currentProduct.value!.originalPrice}";
    quantityController.text = "${currentProduct.value!.quantity}";
  }

  void pressAddProduct() {
    codeController.text = "";
    nameController.text = "";
    priceController.text = "";
    originalPriceController.text = "";
    quantityController.text = "";
    historyProduct = currentProduct.value;
  }

  Future<void> addProduct() async {
    isLoading.value = true;
    _controller.firestore
        .uploadProduct(
      Product(
        id: const Uuid().v1(),
        name: nameController.text,
        price: int.parse(priceController.text),
        originalPrice: int.parse(originalPriceController.text),
        quantity: int.parse(quantityController.text),
        dateTime: DateTime.now(),
        remainQuantity: int.parse(quantityController.text),
        outOfOrder: false,
      ),
    )
        .then((value) {
      if (value) {
        isLoading.value = false;
        Get.back();
        Get.snackbar("Success", "Order submit is success.");
      } else {
        isLoading.value = false;
        Get.snackbar("Fail", "Order submit is fail.");
      }
    });
  }

  @override
  void onInit() {
    ever(isLoading, showLoadingProgress);

    _controller = Get.find();
    if (_controller.productList.isNotEmpty) {
      currentProduct.value = _controller.productList.first;
      codeController.text = _controller.productList.first.id;
      nameController.text = _controller.productList.first.name;
      priceController.text = "${_controller.productList.first.price}";
      originalPriceController.text =
          "${_controller.productList.first.originalPrice}";
      quantityController.text = "${_controller.productList.first.quantity}";
    }
    ever(_controller.productList, changeTotalProduct);
    changeTotalProduct(_controller.productList);
    changeRemainProduct(_controller.productList);
    super.onInit();
  }

  showLoadingProgress(bool callback) {
    if (callback) {
      Get.dialog(
        const SizedBox(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 6,
            ),
          ),
        ),
        barrierDismissible: false,
        barrierColor: Colors.grey.withOpacity(0),
      );
    } else {
      Get.back();
    }
  }

  changeTotalProduct(List<Product> callback) {
    if (callback.isNotEmpty) {
      int prod = 0;
      totalProduct.value = 0;
      for (var item in callback) {
        prod = prod + item.quantity;
      }
      totalProduct.value = prod;
    }
  }

  void changeRemainProduct(RxList<Product> productList) {
    if (productList.isNotEmpty) {
      int prod = 0;
      remainProduct.value = 0;
      for (var item in productList) {
        prod = prod + item.remainQuantity;
      }
      remainProduct.value = prod;
    }
  }
}
