import 'dart:io';

import 'package:asistencia_fix/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;

  UpdateProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UpdateProfileController fx = Get.put(UpdateProfileController());
    controller.nipC.text = user["nip"];
    controller.nameC.text = user["firstName"];
    controller.lastnameC.text = user["lastName"];
    controller.emailC.text = user["email"];
    controller.positionC.text = user["job"];
    controller.addressHomeC.text = user["addresHome"];
    controller.phoneNumberC.text = user["phonennumber"];
    controller.dobC.text = user["dob"];
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'UPDATE PROFILE',
          style: TextStyle(
              color: maroonColor, fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          const Text(
            "Photo Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["profile"] != null) {
                      return Column(
                        children: [
                          ClipOval(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                user["profile"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.deleteProfile(user["uid"]);
                            },
                            child: const Text("delete"),
                          ),
                        ],
                      );
                    } else {
                      return const Text("no image");
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  controller.pickImage();
                },
                child: const Text("choose"),
              ),
            ],
          ),
          const SizedBox(height: 25),
          TextField(
            readOnly: true,
            autocorrect: false,
            controller: controller.nipC,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              labelText: "NIP",
              prefixIcon: const Icon(Icons.vpn_key),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            readOnly: true,
            autocorrect: false,
            controller: controller.emailC,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            (() {
              print('rebuilf TextFormField ${fx.errorName.value}');
              return TextField(
                autocorrect: false,
                onChanged: fx.namaChanged,
                controller: controller.nameC,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  errorText: fx.errorName.value,
                  labelText: "First Name",
                  prefixIcon: const Icon(Icons.person),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Obx(
            (() {
              print('rebuilf TextFormField ${fx.errorName.value}');
              return TextField(
                autocorrect: false,
                onChanged: fx.namaChanged,
                controller: controller.lastnameC,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  errorText: fx.errorName.value,
                  labelText: "Last Name",
                  prefixIcon: const Icon(Icons.person),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Obx(
            (() {
              print('rebuilf TextFormField ${fx.errorPosi.value}');
              return TextField(
                autocorrect: false,
                onChanged: fx.posiChanged,
                controller: controller.positionC,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: fx.errorPosi.value,
                  labelText: "Position",
                  prefixIcon: const Icon(Icons.join_full),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  //hintText: "enter Position",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Obx(
            (() {
              print('rebuilf TextFormField ${fx.errorPho.value}');
              return TextField(
                autocorrect: false,
                onChanged: fx.phoChanged,
                controller: controller.phoneNumberC,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  errorText: fx.errorPho.value,
                  labelText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  //hintText: "Enter Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Obx(
            (() {
              print('rebuilf TextFormField ${fx.errorDob.value}');
              return TextField(
                autocorrect: false,
                onChanged: fx.dobChanged,
                controller: controller.dobC,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  errorText: fx.errorDob.value,
                  labelText: "Date of Birth",
                  prefixIcon: const Icon(Icons.date_range),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  //hintText: "Enter Date of Birth(dd-MM-yyyy)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: () {
                  controller.getDate();
                },
              );
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            (() {
              print('rebuilf TextFormField ${fx.errorAdd.value}');
              return TextField(
                autocorrect: false,
                onChanged: fx.addreChanged,
                controller: controller.addressHomeC,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  errorText: fx.errorAdd.value,
                  labelText: "Adress",
                  prefixIcon: const Icon(Icons.pin_drop),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  //hintText: "Input Addres",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                textInputAction: TextInputAction.next,
              );
            }),
          ),
          const SizedBox(height: 30),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(user["uid"]);
                }
              },
              child: Text(controller.isLoading.isFalse
                  ? "UPDATE PROFILE"
                  : "LOADING..."),
              style: ElevatedButton.styleFrom(
                  primary: memerahtua,
                  fixedSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ],
      ),
    );
  }
}
