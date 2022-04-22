import 'package:asistencia_fix/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:asistencia_fix/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController fx = Get.put(LoginController());
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('LOGIN'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(43.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Log In',
                    style: TextStyle(
                        color: maroonColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    (() {
                      print('rebuilf TextField ${fx.errorEmail.value}');
                      return TextField(
                        autocorrect: false,
                        onChanged: fx.emaChanged,
                        controller: controller.emailC,
                        decoration: InputDecoration(
                          errorText: fx.errorEmail.value,
                          //labelText: "Email",
                          prefixIcon: const Icon(Icons.mail),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Enter Email",
                          border: const OutlineInputBorder(),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  Obx(
                    (() {
                      print('rebuilf TextField ${fx.errorPass.value}');
                      return TextField(
                        autocorrect: false,
                        obscureText: true,
                        onChanged: fx.passChanged,
                        controller: controller.passC,
                        decoration: InputDecoration(
                          errorText: fx.errorPass.value,
                          //labelText: "Password",
                          prefixIcon: const Icon(Icons.key),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Enter Password",
                          border: const OutlineInputBorder(),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                        child: const Text(
                          "Forgot password ?",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Color(0xff7F0000),
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Obx(
                    () => ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.login();
                        }
                      },
                      child: Text(controller.isLoading.isFalse
                          ? "LOGIN"
                          : "LOADING..."),
                      style: ElevatedButton.styleFrom(
                          primary: memerahtua,
                          fixedSize: const Size(300, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Row(
                    children: const <Widget>[
                      Text(
                        "Don't have an account yet? Call Admin",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  const SizedBox(
                    height: 130,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
