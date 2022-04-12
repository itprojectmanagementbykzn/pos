import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pos_system/constant/constant.dart';
import 'package:pos_system/model/order_data.dart';
import 'package:pos_system/service/firestore.dart';
import 'package:pos_system/utils/route_url.dart';

import '../model/coupon.dart';
import '../model/product.dart';

class AllController extends GetxController {
  Rxn<User?> currentUser = Rxn<User?>();
  final firestore = Firestore.instance();
  var currentNavIndex = 0.obs;
  RxList<Product> productList = <Product>[].obs;
  RxList<Coupon> couponList = <Coupon>[].obs;

  void changeCurrentNavIndex(int value) {
    currentNavIndex.value = value;
  }

  void addition(Product product) {
    var originalCount = product.count;
    if (originalCount! < product.remainQuantity) {
      productList[productList.indexOf(product)] =
          productList[productList.indexOf(product)]
              .copyWith(count: originalCount + 1);
    }
  }

  void subtration(Product product) {
    var originalCount = product.count;
    if (originalCount! > 0) {
      productList[productList.indexOf(product)] =
          productList[productList.indexOf(product)]
              .copyWith(count: originalCount - 1);
    }
  }

  String redirectRoute() {
    return currentUser.value == null ? loginUrl : homeUrl;
  }

  Future<void> uploadOrder(OrderData orderData, Product product) async {
    firestore.uploadOrder(orderData, product).then((value) {
      if (value) {
        Get.snackbar("Success", "Order submit is success.");
      } else {
        Get.snackbar("Fail", "Order submit is fail.");
      }
    });
  }

  Future<void> removeCoupon(String documentID) async {
    await firestore.deleteCoupon(documentID);
  }

  @override
  void onInit() {
    //Listen Current User Change
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        currentUser.value = null;
      } else {
        currentUser.value = user;

        //List Product Data
        firestore.listenProduct().listen((event) {
          debugPrint("*********${event.docs.length}");
          productList.value =
              event.docs.map((e) => Product.fromJson(e.data(), e)).toList();
        });

        //List Product Data
        firestore.listenCoupon().listen((event) {
          debugPrint("*********${event.docs.length}");
          couponList.value =
              event.docs.map((e) => Coupon.fromJson(e.data())).toList();
        });
      }
    });
    super.onInit();
  }
}
