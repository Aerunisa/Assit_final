import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataAdminController extends GetxController {
  DateTime? start;
  DateTime end = DateTime.now();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getPresence() async {
    // ignore: avoid_print
    print(start);
    // ignore: avoid_print
    print(end);

    if (start == null) {
      // get seluruh presensi sampai saat ini
      return await firestore.collectionGroup("presence").get();
    } else {
      return await firestore.collectionGroup("presence").get();
    }
  }

  final Query<Map<String, dynamic>> _collectionRef = FirebaseFirestore.instance
      .collectionGroup('collection')
      .where('uid', isEqualTo: 'uid');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    // ignore: avoid_print
    print(allData);
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;
    update();
    Get.back();
  }
}
