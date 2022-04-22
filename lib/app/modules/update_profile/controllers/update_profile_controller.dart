import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:intl/intl.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController lastnameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController positionC = TextEditingController();
  TextEditingController addressHomeC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController dobC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> updateProfile(String uid) async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        lastnameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        positionC.text.isNotEmpty &&
        addressHomeC.text.isNotEmpty &&
        phoneNumberC.text.isNotEmpty &&
        dobC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref('$uid/profile.$ext').putFile(file);
          String urlImage =
              await storage.ref('$uid/profile.$ext').getDownloadURL();

          data.addAll({"profile": urlImage});
        }
        await firestore.collection("users").doc(uid).update(data);
        image = null;
        Get.snackbar("Successful", "Profile update was successful.");
        //"Berhasil", "Berhasil update profile.");
      } catch (e) {
        Get.snackbar("An error occurred", "Unable to update profile.");
        //"Terjadi Kesalahan", "Tidak dapat update profile.");
      } finally {
        isLoading.value = false;
      }
    }
  }

  void deleteProfile(String uid) async {
    try {
      await firestore.collection("pegawai").doc(uid).update({
        "profile": FieldValue.delete(),
      });

      Get.back();
      Get.snackbar("Berhasil", "Berhasil delete profile picture.");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat delete profile picture.");
    } finally {
      update();
    }
  }

  RxString name = RxString('');
  RxString dob = RxString('');
  RxString addre = RxString('');
  RxString posit = RxString('');
  RxString phone = RxString('');
  RxnString errorPho = RxnString(null);
  RxnString errorDob = RxnString(null);
  RxnString errorName = RxnString(null);
  RxnString errorPosi = RxnString(null);
  RxnString errorAdd = RxnString(null);
  //Rxn<Function()> submitfunc = Rxn<Function()>(null);

  @override
  void onInit() {
    super.onInit();
    debounce<String>(name, validationsPanjangName,
        time: const Duration(milliseconds: 500));
    debounce<String>(dob, validationDOB,
        time: const Duration(milliseconds: 500));
    debounce<String>(posit, validationsPanjangPos,
        time: const Duration(milliseconds: 500));
    debounce<String>(addre, validationsPanjangAdd,
        time: const Duration(milliseconds: 500));
    debounce<String>(phone, validationsphone,
        time: const Duration(milliseconds: 500));
  }

  void validationsPanjangName(String val) async {
    errorName.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (lengthName(val)) {
        print('All validations passed, Click submit button');
        errorName.value = null;
      }
    }
  }

  void validationsPanjangPos(String val) async {
    errorPosi.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (lengthPosi(val)) {
        print('All validations passed, Click submit button');
        errorPosi.value = null;
      }
    }
  }

  void validationsPanjangAdd(String val) async {
    errorAdd.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (lengthAddr(val)) {
        print('All validations passed, Click submit button');
        errorAdd.value = null;
      }
    }
  }

  void validationsphone(String val) async {
    errorPho.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (lengthPho(val)) {
        print('All validations passed, Click submit button');
        errorPho.value = null;
      }
    }
  }

  void validationDOB(String val) async {
    errorDob.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (aturanDOB(val)) {
        print('All validations passed, Click submit button');
        errorDob.value = null;
      }
    }
  }

  bool lengthName(String val, {int minLen = 5}) {
    if (val.length < minLen) {
      errorName.value = 'min. 5 chars';
      return false;
    }
    return true;
  }

  bool lengthPosi(String val, {int minLen = 5}) {
    if (val.length < minLen) {
      errorPosi.value = 'min. 5 chars';
      return false;
    }
    return true;
  }

  bool lengthAddr(String val, {int minLen = 10}) {
    if (val.length < minLen) {
      errorAdd.value = 'min. 10 chars';
      return false;
    }
    return true;
  }

  bool lengthPho(String val, {int minLen = 11}) {
    if (val.length < minLen && !RegExp("[0-9]").hasMatch(val)) {
      errorPho.value = 'min. 11 chars';
      return false;
    }
    return true;
  }

  bool aturanDOB(String val, {int minLen = 10}) {
    if (!RegExp("[0-9]+/[0-9]+/[0-9]").hasMatch(val) && val.length == minLen) {
      errorDob.value = 'Format Date DD-MM-YYYY';
      return false;
    }
    return true;
  }

  void namaChanged(String val) {
    name.value = val;
  }

  void dobChanged(String val) {
    dob.value = val;
  }

  void posiChanged(String val) {
    posit.value = val;
  }

  void addreChanged(String val) {
    addre.value = val;
  }

  void phoChanged(String val) {
    phone.value = val;
  }

  var selectDate = DateTime.now().obs;
  Future<dynamic> getDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectDate.value,
        firstDate: DateTime(1965),
        lastDate: DateTime(2023),
        helpText: 'Select Date of Birth',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid Date',
        errorInvalidText: 'Enter valid date range',
        fieldLabelText: 'DOB',
        fieldHintText: 'Date/Month/Year');
    //dobC.text = pickedDate!.toIso8601String();
    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      dobC.text = formattedDate;
    }
    // if (pickedDate != null && pickedDate != selectDate.value) {
    //   selectDate.value = pickedDate;
    //print('berhasil diambil');

    //  return pickedDate;

    //chooseDate().value = pickedDate;
    //dobC;
    //}
  }
}
