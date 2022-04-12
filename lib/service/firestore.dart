import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pos_system/constant/constant.dart';
import 'package:pos_system/model/order_data.dart';
import 'package:pos_system/model/product.dart';

import '../model/coupon.dart';

class Firestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Firestore._();

  static Firestore instance() => Firestore._();

  Future<bool> uploadProduct(Product data) async {
    Completer<bool> _completer = Completer();
    _firestore
        .collection(productCollection)
        .add(data.toJson())
        .then((value) => _completer.complete(true), onError: (obj) {
      debugPrint("******Firestore UploadOrder Error: $obj****");
      _completer.complete(false);
    });
    return _completer.future;
  }

  Future<bool> uploadOrder(OrderData data, Product product) async {
    Completer<bool> _completer = Completer();
    _firestore
        .collection("${DateTime.now().year}Collection")
        .doc("${DateTime.now().year},${DateTime.now().month}")
        .set({
      "dateTime": {
        dailyMapKey: {
          "orderDataList": FieldValue.arrayUnion([data.toJson()]),
        }
      }
    }, SetOptions(merge: true)).then((value) async {
      await updateTotalForDaily(product);
      await updateRemainQuantity(product);
      await updateTotalForMonthly(product);
      _completer.complete(true);
    }, onError: (obj) {
      debugPrint("******Firestore UploadOrder Error: $obj****");
      _completer.complete(false);
    });
    return _completer.future;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
      getDaysInCurrentMonthList() async {
    return await _firestore
        .collection("${DateTime.now().year}Collection")
        .doc("${DateTime.now().year},3") //TODO CHANGE FOR MONTH
        .get();
  }

  //Get Monthly Sales Data
  Future<QuerySnapshot<Map<String, dynamic>>> getMonthlySalesData({
    String? yearCollection,
  }) async {
    yearCollection ??= thisYearColleciton;

    return await _firestore
        .collection(yearCollection)
        .orderBy("dateTimeMonth")
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenProduct() {
    return _firestore
        .collection(productCollection)
        .orderBy("dateTime", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenCoupon() {
    return _firestore
        .collection(couponCollection)
        .orderBy("startDate", descending: true)
        .snapshots();
  }

  //Delete Coupon
  Future<void> deleteCoupon(String documentID) async {
    await _firestore.collection(couponCollection).doc(documentID).delete();
  }

  //Add Coupon
  Future<void> uploadCoupon(Coupon coupon) async {
    await _firestore.collection(couponCollection).add(coupon.toJson());
  }

  //Subtract Remain Product
  Future<void> updateRemainQuantity(Product product) async {
    debugPrint("******${product.snapshot}*****");
    _firestore.runTransaction((transaction) async {
      //secure snapshot
      final secureSnapshot = await transaction.get(product.snapshot!.reference);

      final int remainQuan = secureSnapshot.get("remainQuantity") as int;

      transaction.update(secureSnapshot.reference, {
        "remainQuantity": remainQuan - product.count!,
      });
    });
  }

  //Update TotalOrder and TotalPrice in today Map
  Future<void> updateTotalForDaily(Product product) async {
    _firestore.runTransaction((transaction) async {
      //secure snapshot
      final secureSnapshot = await transaction.get(_firestore
          .collection("${DateTime.now().year}Collection")
          .doc("${DateTime.now().year},${DateTime.now().month}"));
      debugPrint("*******${secureSnapshot.get("dateTime")}****");

      try {
        final map = secureSnapshot.get("dateTime") as Map<String, dynamic>;
        final todayMap = map[dailyMapKey] as Map<String, dynamic>;
        final int totalOrder = todayMap["totalOrder"];
        final int totalPrice = todayMap["totalRevenue"];
        final int totalOriginalPrice = todayMap["originalTotalRevenue"];
        transaction.set(
            secureSnapshot.reference,
            {
              "dateTime": {
                dailyMapKey: {
                  "totalOrder": totalOrder + 1,
                  "totalRevenue": totalPrice + product.price * product.count!,
                  "originalTotalRevenue": totalOriginalPrice +
                      product.originalPrice * product.count!,
                },
              },
            },
            SetOptions(merge: true));
      } catch (e) {
        debugPrint("*********Error get totalOrder and Price $e**");
        transaction.set(
            secureSnapshot.reference,
            {
              "dateTime": {
                dailyMapKey: {
                  "totalOrder": 1,
                  "totalRevenue": product.price * product.count!,
                  "originalTotalRevenue":
                      product.originalPrice * product.count!,
                }
              },
            },
            SetOptions(merge: true));
      }
    });
  }

  //Update TotalOrder and TotalPrice in today Map
  Future<void> updateTotalForMonthly(Product product) async {
    _firestore.runTransaction((transaction) async {
      //secure snapshot
      final secureSnapshot = await transaction.get(_firestore
          .collection("${DateTime.now().year}Collection")
          .doc("${DateTime.now().year},${DateTime.now().month}"));
      debugPrint("*******Monthly:$secureSnapshot****");

      try {
        final int totalOrder = secureSnapshot.get("totalOrder");
        final int totalPrice = secureSnapshot.get("totalRevenue");
        final int totalOriginalPrice =
            secureSnapshot.get("originalTotalRevenue");
        transaction.set(
            secureSnapshot.reference,
            {
              "totalOrder": totalOrder + 1,
              "totalRevenue": totalPrice + product.price * product.count!,
              "originalTotalRevenue":
                  totalOriginalPrice + product.originalPrice * product.count!,
              "dateTimeMonth": DateTime.now(),
            },
            SetOptions(merge: true));
      } catch (e) {
        debugPrint("*********Error get totalOrder and Price $e**");
        transaction.set(
            secureSnapshot.reference,
            {
              "totalOrder": 1,
              "totalRevenue": product.price * product.count!,
              "originalTotalRevenue": product.originalPrice * product.count!,
              "dateTimeMonth": DateTime.now(),
            },
            SetOptions(merge: true));
      }
    });
  }
}
