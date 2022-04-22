import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:asistencia_fix/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:asistencia_fix/app/routes/app_pages.dart';

import '../controllers/all_presensi_controller.dart';

class AllPresensiView extends GetView<AllPresensiController> {
  const AllPresensiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('ALL DATA PRESENCE'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: bata,
        titleTextStyle: boldSSPro.copyWith(
          fontSize: 25,
          color: putih,
        ),
      ),
      body: GetBuilder<AllPresensiController>(
        builder: (c) => FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.getPresence(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snap.data?.docs.length == 0 || snap.data == null) {
              return const SizedBox(
                height: 150,
                child: Center(
                  child: Text("There is no presence history yet."),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: snap.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snap.data!.docs[index].data();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () => Get.toNamed(
                        Routes.DETAIL_PRESENSI,
                        arguments: data,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(103, 100, 15, 15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Masuk",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xDD000000),
                                  ),
                                ),
                                Text(
                                  "${DateFormat.yMMMEd().format(DateTime.parse(data['date']))}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xDD000000),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              data['masuk']?['date'] == null
                                  ? "-"
                                  : "${DateFormat.jms().format(DateTime.parse(data['masuk']!['date']))}",
                              style: const TextStyle(
                                color: Color(0xDD000000),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Keluar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xDD000000),
                              ),
                            ),
                            Text(
                              data['keluar']?['date'] == null
                                  ? "-"
                                  : "${DateFormat.jms().format(DateTime.parse(data['keluar']!['date']))}",
                              style: const TextStyle(
                                color: Color(0xDD000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: bata,
        onPressed: () {
          // syncfusion datepicker
          Get.dialog(
            Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 400,
                color: pinktengah,
                child: SfDateRangePicker(
                  monthViewSettings:
                      const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (obj) {
                    if (obj != null) {
                      if ((obj as PickerDateRange).endDate != null) {
                        controller.pickDate(obj.startDate!, obj.endDate!);
                      }
                    }
                  },
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.format_list_bulleted_rounded),
      ),
    );
  }
}
