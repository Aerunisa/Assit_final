import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController currC = TextEditingController();
  TextEditingController newC = TextEditingController();
  TextEditingController confirmC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePass() async {
    if (currC.text.isNotEmpty &&
        newC.text.isNotEmpty &&
        confirmC.text.isNotEmpty) {
      if (newC.text == confirmC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currC.text);

          await auth.currentUser!.updatePassword(newC.text);

          Get.back();

          Get.snackbar("Successful", "Password update was successful");
          //"Berhasil", "Berhasil update password");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("An error occurred",
                "Invalid password was entered. Unable to update password.");
            //"Terjadi Kesalahan","Password yang dimasukan salah. Tidak dapat update password.");
          } else {
            Get.snackbar("An error occurred", "${e.code.toLowerCase()}");
          }
        } catch (e) {
          Get.snackbar("An error occurred", "Can't update password");
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Terjadi Kesalahan", "Confirm password tidak cocok.");
        //"Terjadi Kesalahan", "Confirm password tidak cocok.");
      }
    } else {
      Get.snackbar("An error occurred", "All inputs are required");
      //"Terjadi Kesalahan", "Semua input harus diisi");
    }
  }

  RxString pass = RxString('');
  RxString newPas = RxString('');
  RxString conf = RxString('');
  RxnString errorPass = RxnString(null);
  RxnString errorNew = RxnString(null);
  RxnString errorConf = RxnString(null);
  @override
  void onInit() {
    super.onInit();
    debounce<String>(pass, validationsPass,
        time: const Duration(milliseconds: 500));
    debounce<String>(newPas, validationsNew,
        time: const Duration(milliseconds: 500));
    debounce<String>(conf, validationsConf,
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

  void validationsNew(String val) async {
    errorNew.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (lengthNew(val)) {
        print('All validations passed, Click submit button');
        errorNew.value = null;
      }
    }
  }

  bool lengthNew(String val, {int minLen = 8}) {
    if (val.length < minLen) {
      errorNew.value = 'min. 8 chars';
      return false;
    }
    return true;
  }

  void newChanged(String val) {
    newPas.value = val;
  }

  void validationsConf(String val) async {
    errorConf.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (lengthConf(val)) {
        print('All validations passed, Click submit button');
        errorConf.value = null;
      }
    }
  }

  bool lengthConf(String val, {int minLen = 8}) {
    if (val.length < minLen) {
      errorConf.value = 'min. 8 chars';
      return false;
    }
    return true;
  }

  void confChanged(String val) {
    conf.value = val;
  }
}
