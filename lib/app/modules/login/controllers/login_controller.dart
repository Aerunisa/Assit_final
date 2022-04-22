import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asistencia_fix/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Not yet verified",
              // "Belum Verifikasi",
              middleText:
                  "You haven't verified this account. Verify your email.",
              //"Kamu belum verifikasi akun ini. Lakukan verifikasi diemail kamu.",
              actions: [
                OutlinedButton(
                  onPressed: () {
                    isLoading.value = false;
                    Get.back();
                  }, // bisa buat tutup dialog
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back(); // bisa buat tutup dialog
                      Get.snackbar("Success",
                          "We have successfully sent a verification email to your account.");
                      //"Berhasil","Kami telah berhasil mengirim email verifikasi ke akun kamu.");
                      isLoading.value = false;
                    } catch (e) {
                      isLoading.value = false;
                      Get.snackbar("An error occurred",
                          "Unable to send verification email. Please contact admin or customer service.");
                      //"Terjadi Kesalahan","Tidak dapat mengirim email verifikasi. Hubungi admin atau customer service.");
                    }
                  },
                  child: const Text("RESENDING"),
                  //"KIRIM ULANG"),
                ),
              ],
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("An error occurred", "Email is not registered");
          //"Terjadi Kesalahan", "Email tidak terdaftar");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("An error occurred", "Invalid password");
          //"Terjadi Kesalahan", "Password salah");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("An error occurred", "Unable to login.");
        //"Terjadi Kesalahan", "Tidak dapat login.");
      }
    } else {
      Get.snackbar("An error occurred", "Email and password are required.");
      //"Terjadi Kesalahan", "Email dan password wajib diisi.");
    }
  }

  RxString email = RxString('');
  RxnString errorEmail = RxnString(null);
  RxString pass = RxString('');
  RxnString errorPass = RxnString(null);
  @override
  void onInit() {
    super.onInit();
    debounce<String>(email, validationsEmail,
        time: const Duration(milliseconds: 500));
    debounce<String>(pass, validationsPass,
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
