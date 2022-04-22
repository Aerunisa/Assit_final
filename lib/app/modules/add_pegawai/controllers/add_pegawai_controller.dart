import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AddPegawaiController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddPegawai = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController lastnameC = TextEditingController(); //////////////////
  TextEditingController positionC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();
  TextEditingController addressHomeC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController dobC = TextEditingController();

  String? _fname;
  String? _lname;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddPegawai.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

        UserCredential pegawaiCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
            firstName: _fname,
            id: pegawaiCredential.user!.uid,
            imageUrl: 'https://i.pravatar.cc/300?u=$email',
            lastName: _lname,
          ),
        );

        if (pegawaiCredential.user != null) {
          String uid = pegawaiCredential.user!.uid;

          await firestore.collection("users").doc(uid).set({
            "nip": nipC.text,
            "firstName": nameC.text,
            "lastName": lastnameC.text, /////////////////////////////////
            "job": positionC.text,
            "email": emailC.text,
            "phonennumber": phoneNumberC.text,
            "gender": genderC.text,
            "dob": dobC.text,
            "addresHome": addressHomeC.text,
            "uid": uid,
            "role": "user",
            "tanggalDaftar": DateTime.now().toIso8601String(),
          });

          await pegawaiCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text,
          );

          Get.back(); // tutup dialog
          Get.back(); // back to home
          Get.snackbar("Success", "Successfully add employee");
          //"Berhasil", "Berhasil menambahkan pegawai");

        }
        isLoadingAddPegawai.value = false;
      } on FirebaseAuthException catch (e) {
        isLoadingAddPegawai.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar("An error occurred", "The password used is too short");
          //"Terjadi Kesalahan", "Password yang digunakan terlalu singkat");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("An error occurred",
              "Employee already exists. You cannot add employees with this email.");
          //"Terjadi Kesalahan","Pegawai sudah ada. Kamu tidak dapat menambahkan pegawai dengan email ini.");
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "An error occurred", "Admin cannot login. Wrong password!");
          //"Terjadi Kesalahan", "Admin tidak dapat login. Password salah !");
        } else {
          Get.snackbar("An error occurred", "${e.code}");
          //"Terjadi Kesalahan", "${e.code}");
        }
      } catch (e) {
        isLoadingAddPegawai.value = false;
        Get.snackbar("An error occurred", "Unable to add employee.");
        //"Terjadi Kesalahan", "Tidak dapat menambahkan pegawai.");
      }
    } else {
      isLoading.value = false;

      Get.snackbar(
          "An error occurred", "Password is required for validation purposes");
      //"Terjadi Kesalahan", "Password wajib diisi untuk keperluan validasi");
    }
  }

  Future<void> addPegawai() async {
    if (nameC.text.isNotEmpty &&
        positionC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        dobC.text.isNotEmpty &&
        addressHomeC.text.isNotEmpty &&
        genderC.text.isNotEmpty &&
        phoneNumberC.text.isNotEmpty &&
        lastnameC.text.isNotEmpty && //////////////
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
        title: "Validasi Admin",
        content: Column(
          children: [
            const Text("Enter password for admin validation!"),
            //"Masukan password untuk validasi admin !"),
            const SizedBox(height: 10),
            TextField(
              controller: passAdminC,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              isLoading.value = false;
              Get.back();
            },
            child: const Text("CANCEL"),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (isLoadingAddPegawai.isFalse) {
                  await prosesAddPegawai();
                }
                isLoading.value = false;
              },
              child: Text(
                  isLoadingAddPegawai.isFalse ? "ADD PEGAWAI" : "LOADING.."),
            ),
          ),
        ],
      );
    } else {
      Get.snackbar("An error occurred",
          "You are still have empty fields, must be filled in.");
      //"Terjadi Kesalahan", "NIP, nama, job dan email harus diisi.");
    }
  }

  RxString nip = RxString('');
  RxString name = RxString('');
  RxString email = RxString('');
  RxString dob = RxString('');
  RxString addre = RxString('');
  RxString posit = RxString('');
  RxString phone = RxString('');
  RxString gender = RxString('');
  RxnString errorText = RxnString(null);
  RxnString errorPho = RxnString(null);
  RxnString errorGender = RxnString(null);
  RxnString errorEmail = RxnString(null);
  RxnString errorDob = RxnString(null);
  RxnString errorName = RxnString(null);
  RxnString errorPosi = RxnString(null);
  RxnString errorAdd = RxnString(null);
  //Rxn<Function()> submitfunc = Rxn<Function()>(null);

  @override
  void onInit() {
    super.onInit();
    debounce<String>(nip, validationsPanjangNip,
        time: const Duration(milliseconds: 500));
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
    debounce<String>(gender, validationGender,
        time: const Duration(milliseconds: 500));
    debounce<String>(email, validationsEmail,
        time: const Duration(milliseconds: 500));
  }

  void validationsPanjangNip(String nipp) async {
    errorText.value = null; // reset validation errors to nothing
    if (nipp.isNotEmpty) {
      if (lengthOK(nipp)) {
        print('All validations passed, Click submit button');
        errorText.value = null;
      }
    }
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

  void validationGender(String val) async {
    errorGender.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (aturanGender(val)) {
        print('All validations passed, Click submit button');
        errorGender.value = null;
      }
    }
  }

  void validationsEmail(String val) async {
    errorEmail.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (aturanEmail(val) && lengthAddr(val)) {
        print('All validations passed, Click submit button');
        errorEmail.value = null;
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

  bool lengthOK(String nipp, {int minLen = 5}) {
    if (nipp.length < minLen) {
      errorText.value = 'min. 5 chars';
      return false;
    }
    return true;
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

  bool aturanEmail(String val, {int minLen = 12}) {
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val) &&
        val.length < minLen) {
      errorEmail.value = 'Format Email use @example.com';
      return false;
    }
    return true;
  }

  bool aturanGender(String val, {int minLen = 4}) {
    if (val.length < minLen) {
      //RegExp("Wanita").hasMatch(val) || RegExp("Pria").hasMatch(val)) {
      errorGender.value = 'Format Gender Male or Female';
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

  void nipChanged(String nipp) {
    nip.value = nipp;
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

  void gendChanged(String val) {
    gender.value = val;
  }

  void emaChanged(String val) {
    email.value = val;
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

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 5))))) {
      return true;
    }
    return false;
  }
}
