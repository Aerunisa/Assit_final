import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../data_emp_model.dart';

class DataEmpController extends GetxController {
//FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;
  RxList<DataEmployeeModel> pegawai = RxList<DataEmployeeModel>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    collectionReference = firestore.collection("users");
    pegawai.bindStream(getDataEmploye());
  }

  Stream<List<DataEmployeeModel>> getDataEmploye() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => DataEmployeeModel.fromMap(item)).toList());
}
