import 'package:asistencia_fix/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddPegawaiController fx = Get.put(AddPegawaiController());
    return Scaffold(
      backgroundColor: backgroundColor,
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
                    'Register Employee',
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
                        'NIP',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  Obx(
                    (() {
                      print('rebuilf TextFormField ${fx.errorText.value}');
                      return TextField(
                        autocorrect: false,
                        onChanged: fx.nipChanged,
                        controller: controller.nipC,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          errorText: fx.errorText.value,
                          //labelText: "NIP",
                          prefixIcon: const Icon(Icons.vpn_key),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Insert NIP Employee",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                        'Name Employee',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
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
                          //labelText: "Name",
                          prefixIcon: const Icon(Icons.person),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Insert First Name Employee",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ///////////////////////////////////////////////////Test Last Name
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
                          //labelText: "Name",
                          prefixIcon: const Icon(Icons.person),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Insert Last Name Employee",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                        'Position',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  Obx(
                    () {
                      print('rebuilf TextFormField ${fx.errorPosi.value}');
                      return TextField(
                        autocorrect: false,
                        onChanged: fx.posiChanged,
                        controller: controller.positionC,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorText: fx.errorPosi.value,
                          //labelText: "Position",
                          prefixIcon: const Icon(Icons.join_full),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "enter Position",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
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
                  Obx(
                    () {
                      print('rebuilf TextFormField ${fx.errorEmail.value}');
                      return TextField(
                        autocorrect: false,
                        onChanged: fx.emaChanged,
                        controller: controller.emailC,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorText: fx.errorEmail.value,
                          //labelText: "Email",
                          prefixIcon: const Icon(Icons.mail),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Enter Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  Obx(
                    () {
                      print('rebuilf TextFormField ${fx.errorPho.value}');
                      return TextField(
                        autocorrect: false,
                        onChanged: fx.phoChanged,
                        controller: controller.phoneNumberC,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          errorText: fx.errorPho.value,
                          //labelText: "Phone Number",
                          prefixIcon: const Icon(Icons.phone),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Enter Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  Obx(
                    () {
                      print('rebuilf TextFormField ${fx.errorGender.value}');
                      return TextField(
                        autocorrect: false,
                        onChanged: fx.gendChanged,
                        controller: controller.genderC,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorText: fx.errorGender.value,
                          prefixIcon: const Icon(Icons.emoji_people_sharp),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Enter Gender (Female or Male)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Date of Birth',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  Obx(
                    () {
                      print('rebuilf TextFormField ${fx.errorDob.value}');
                      return TextField(
                        autocorrect: false,
                        onChanged: fx.dobChanged,
                        controller: controller.dobC,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          errorText: fx.errorDob.value,
                          //labelText: "Date of Birth",
                          prefixIcon: const Icon(Icons.date_range),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Enter Date of Birth(dd-MM-yyyy)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onTap: () {
                          controller.getDate();
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Addresss',
                        style: TextStyle(color: blackColor, fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  Obx(
                    () {
                      print('rebuilf TextFormField ${fx.errorAdd.value}');
                      return TextField(
                        autocorrect: false,
                        onChanged: fx.addreChanged,
                        controller: controller.addressHomeC,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          errorText: fx.errorAdd.value,
                          //labelText: "Adress",
                          prefixIcon: const Icon(Icons.pin_drop),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Input Addres",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.addPegawai();
                        }
                      },
                      child: Text(controller.isLoading.isFalse
                          ? "ADD PEGAWAI"
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
            ),
          ),
        ),
      ),
    );
  }
}
