import 'package:asistencia_fix/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/data_emp_controller.dart';

class DataEmpView extends GetView<DataEmpController> {
  const DataEmpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('DATA EMPLOYEE'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: bata,
        titleTextStyle: boldSSPro.copyWith(
          fontSize: 25,
          color: putih,
        ),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: controller.pegawai.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            child: Text(
                              controller.pegawai[index].name!
                                  .substring(0, 3)
                                  .capitalize!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: fixtab,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      controller.pegawai[index].name!,
                                      style: boldSSPro.copyWith(
                                          color: hitam, fontSize: 20),
                                    ),
                                    Text(
                                      controller.pegawai[index].lname!,
                                      style: boldSSPro.copyWith(
                                          color: hitam, fontSize: 20),
                                    ),
                                  ],
                                ),
                                Text(
                                  controller.pegawai[index].job!,
                                  style: normalSSPro.copyWith(
                                      color: memerahtua, fontSize: 18),
                                ),
                                Text(
                                  controller.pegawai[index].email!,
                                  style: normalSSPro.copyWith(
                                      color: bata, fontSize: 18),
                                ),
                                Text(
                                  controller.pegawai[index].phonennumber!,
                                  style: normalSSPro.copyWith(
                                      color: hitam, fontSize: 15),
                                ),
                                Text(
                                  controller.pegawai[index].dob!,
                                  style: normalSSPro.copyWith(
                                      color: hitam, fontSize: 15),
                                ),
                                Text(
                                  controller.pegawai[index].gender!,
                                  style: normalSSPro.copyWith(
                                      color: hitam, fontSize: 15),
                                ),
                                Text(
                                  controller.pegawai[index].addresHome!,
                                  style: normalSSPro.copyWith(
                                      color: hitam, fontSize: 15),
                                ),
                              ]),
                        ]),
                  ),
                ),
              );
            }),
      ),
      // Obx(
      //   () => ListView.builder(
      //     itemCount: controller.pegawai.length,
      //     itemBuilder: (context, index) => Card(
      //       color: whiteColor,
      //       child: ListTile(
      //         title: Text(controller.pegawai[index].name!),
      //         subtitle: Text(controller.pegawai[index].job!),
      //         leading: CircleAvatar(
      //           child: Text(
      //             controller.pegawai[index].name!.substring(0, 1).capitalize!,
      //             style: const TextStyle(fontWeight: FontWeight.bold),
      //           ),
      //           backgroundColor: fixtab,
      //         ),
      //         onTap: () => Get.toNamed(
      //           Routes.HOME,
      //           /////////////////////////// !!!!!!
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
