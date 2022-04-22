import 'package:asistencia_fix/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewPasswordController fx = Get.put(NewPasswordController());
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('NEW PASSWORD'),
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
                    height: 50,
                  ),
                  Text(
                    'Reset Password',
                    style: TextStyle(
                        color: maroonColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  Text(
                    'Please input your new Password to reset your Password',
                    style: TextStyle(color: blackColor, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'New User Only!',
                    style: TextStyle(color: blackColor, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Obx(
                    (() {
                      print('rebuilf TextField ${fx.errorPass.value}');
                      return TextField(
                        autocorrect: false,
                        obscureText: true,
                        onChanged: fx.passChanged,
                        controller: controller.newPassC,
                        decoration: InputDecoration(
                          errorText: fx.errorPass.value,
                          //labelText: "New Password",
                          prefixIcon: const Icon(Icons.key),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Enter New Password",
                          border: const OutlineInputBorder(),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.newPassword();
                    },
                    child: const Text("CONTINUE"),
                  ),
                  const SizedBox(
                    height: 180,
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
