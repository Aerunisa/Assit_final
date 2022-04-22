import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.back();
        Get.snackbar("Success",
            "We have sent a password reset email. Please check your email.");
        //"Berhasil","Kami telah mengirimkan email reset password. Periksa email kamu.");
        //
      } catch (e) {
        Get.snackbar(
            "An error occurred", "Unable to send password reset email.");
        //"Terjadi Kesalahan", "Tidak dapat mengirim email reset password.");
      } finally {
        isLoading.value = false;
      }
    }
  }

  RxString email = RxString('');
  RxnString errorEmail = RxnString(null);
  @override
  void onInit() {
    super.onInit();
    debounce<String>(email, validationsEmail,
        time: const Duration(milliseconds: 500));
  }

  void validationsEmail(String val) async {
    errorEmail.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (aturanEmail(val) && lengthOK(val)) {
        print('All validations passed, Click submit button');
        errorEmail.value = null;
      }
    }
  }

  bool lengthOK(String val, {int minLen = 8}) {
    if (val.length < minLen) {
      errorEmail.value = 'min. 8 chars';
      return false;
    }
    return true;
  }

  bool aturanEmail(String val, {int minLen = 12}) {
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val) &&
        val.length < minLen) {
      errorEmail.value = 'Format Email use @example.com';
      return false;
    }
    return true;
  }

  void emaChanged(String val) {
    email.value = val;
  }
}
