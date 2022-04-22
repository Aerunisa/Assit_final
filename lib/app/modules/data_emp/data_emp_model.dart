import 'package:cloud_firestore/cloud_firestore.dart';

class DataEmployeeModel {
  String? name;
  String? lname;
  String? email;
  String? job;
  String? dob;
  String? phonennumber;
  String? nip;
  String? addresHome;
  String? gender;
  String? uid;

  DataEmployeeModel(
      {this.addresHome,
      this.dob,
      this.lname,
      this.email,
      this.gender,
      this.job,
      this.name,
      this.nip,
      this.phonennumber,
      this.uid});

  DataEmployeeModel.fromMap(DocumentSnapshot data) {
    name = data["firstName"];
    lname = data["lastName"];
    email = data["email"];
    dob = data["dob"];
    job = data["job"];
    uid = data["uid"];
    nip = data["nip"];
    gender = data["gender"];
    phonennumber = data["phonennumber"];
    addresHome = data["addresHome"];
  }
}
