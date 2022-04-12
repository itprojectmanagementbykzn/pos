import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_system/utils/route_url.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  var isLoading = false.obs;

  Future<void> login() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
        .then(
          (value) => Get.toNamed(homeUrl),
          onError: (obj) => Get.snackbar("Error", "Login Error $obj"),
        );
  }

  @override
  void onInit() {
    ever(isLoading, showLoadingDialog);
    super.onInit();
  }

  showLoadingDialog(bool callback) {
    if (callback) {
      Get.defaultDialog(
          barrierDismissible: false,
          content: const SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 6, 114, 9),
            ),
          ));
    } else {
      Get.back();
    }
  }
}
