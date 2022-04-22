import 'package:asistencia_fix/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpdatePasswordController fx = Get.put(UpdatePasswordController());
    return Scaffold(
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
                    height: 40,
                  ),
                  Text(
                    'Reset Password',
                    style: TextStyle(
                        color: maroonColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Current Password',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(
                    (() {
                      print('rebuilf TextField ${fx.errorPass.value}');
                      return TextField(
                        controller: controller.currC,
                        autocorrect: false,
                        obscureText: true,
                        onChanged: fx.passChanged,
                        decoration: InputDecoration(
                          errorText: fx.errorPass.value,
                          prefixIcon: const Icon(Icons.mail),
                          labelText: "Current Password",
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
                        'New Password',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(
                    (() {
                      print('rebuilf TextField ${fx.errorNew.value}');
                      return TextField(
                        controller: controller.newC,
                        autocorrect: false,
                        obscureText: true,
                        onChanged: fx.newChanged,
                        decoration: InputDecoration(
                          errorText: fx.errorNew.value,
                          prefixIcon: const Icon(Icons.mail),
                          labelText: "New Password",
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
                        'Confirm Password',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(
                    (() {
                      print('rebuilf TextField ${fx.errorConf.value}');
                      return TextField(
                        controller: controller.confirmC,
                        autocorrect: false,
                        obscureText: true,
                        onChanged: fx.confChanged,
                        decoration: InputDecoration(
                          errorText: fx.errorConf.value,
                          prefixIcon: const Icon(Icons.mail),
                          labelText: "Confirm New Password",
                          border: const OutlineInputBorder(),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        if (controller.isLoading.isFalse) {
                          controller.updatePass();
                        }
                      },
                      child: Text((controller.isLoading.isFalse)
                          ? "CHANGE PASSWORD"
                          : "LOADING..."),
                      style: ElevatedButton.styleFrom(
                          primary: memerahtua,
                          fixedSize: const Size(300, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
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
