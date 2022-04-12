import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pos_system/controller/login_controller.dart';
import 'package:pos_system/utils/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _controller = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: backgroundBoxDecoration,
          child: Center(
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Space
                    const SizedBox(
                      height: 25,
                    ),
                    //App Text
                    Text(
                      "SHOPIER",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                    ),
                    //Space
                    const SizedBox(
                      height: 25,
                    ),
                    //UserName TextField
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Container(
                        decoration: loginBoxDecoration,
                        child: TextField(
                          controller: _controller.emailController,
                          decoration:
                              inputDecoration("User name", Icons.person),
                        ),
                      ),
                    ),
                    //Space
                    const SizedBox(
                      height: 15,
                    ),
                    //Password TextField
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Container(
                        decoration: loginBoxDecoration,
                        child: TextField(
                          controller: _controller.passwordController,
                          decoration: inputDecoration("Password", Icons.lock),
                        ),
                      ),
                    ),
                    //Space
                    const SizedBox(
                      height: 15,
                    ),
                    //Login Button
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor("6CBEB4"),
                          side: const BorderSide(color: Colors.white, width: 1),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                          //TODO: DO SOMETHING
                          _controller.login();
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Space
                    const SizedBox(
                      height: 50,
                    ),
                    //Bottom Line
                    const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "By shopier",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
