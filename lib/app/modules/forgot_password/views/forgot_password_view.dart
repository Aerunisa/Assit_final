import 'package:asistencia_fix/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForgotPasswordController fx = Get.put(ForgotPasswordController());
    return Scaffold(
      backgroundColor: backgroundColor,
      // appBar: AppBar(
      //   title: const Text('FORGOT PASSWORD'),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: bata,
      //   titleTextStyle: boldSSPro.copyWith(
      //     fontSize: 25,
      //     color: putih,
      //   ),
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
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: maroonColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  Text(
                    'Please input your email to reset your Password',
                    style: TextStyle(color: blackColor, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 25,
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Enter Email",
                          border: const OutlineInputBorder(),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        if (controller.isLoading.isFalse) {
                          controller.sendEmail();
                        }
                      },
                      child: Text(controller.isLoading.isFalse
                          ? "SEND RESET PASSWORD"
                          : "LOADING..."),
                      style: ElevatedButton.styleFrom(
                          primary: memerahtua,
                          fixedSize: const Size(300, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
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
