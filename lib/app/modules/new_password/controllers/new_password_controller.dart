import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asistencia_fix/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password") {
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPassC.text,
          );

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("An error occurred",
                "Password is too weak, at least 6 characters long.");
            //"Terjadi Kesalahan","Password terlalu lemah, setidaknya 6 karakter.");
          }
        } catch (e) {
          Get.snackbar("An error occurred",
              "Unable to create a new password. Please contact admin / customer service.");
          //"Terjadi Kesalahan","Tidak dapat membuat password baru. Hubungi admin / customer service.");
        }
      } else {
        Get.snackbar("An error occurred",
            "The new password must be changed, do not return the 'password'.");
        //"Terjadi Kesalahan","Password baru harus diubah, jangan 'password' kembali.");
      }
    } else {
      Get.snackbar("An error occurred", "New password is required");
      //"Terjadi Kesalahan", "Password baru wajib diisi");
    }
  }

  RxString pass = RxString('');
  RxnString errorPass = RxnString(null);
  @override
  void onInit() {
    super.onInit();
    debounce<String>(pass, validationsPass,
        time: const Duration(milliseconds: 500));
  }

  void validationsPass(String val) async {
    errorPass.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (lengthPass(val)) {
        print('All validations passed, Click submit button');
        errorPass.value = null;
      }
    }
  }

  bool lengthPass(String val, {int minLen = 8}) {
    if (val.length < minLen) {
      errorPass.value = 'min. 8 chars';
      return false;
    }
    return true;
  }

  void passChanged(String val) {
    pass.value = val;
  }
}
