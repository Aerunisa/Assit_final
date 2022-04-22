import 'package:asistencia_fix/rooms.dart';
import 'package:asistencia_fix/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:asistencia_fix/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import '../../../controllers/page_index_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageC = Get.find<PageIndexController>();

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Assistencia',
          style: logo.copyWith(
            fontSize: 30,
            color: bata,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        titleTextStyle: boldSSPro.copyWith(
          fontSize: 25,
          color: putih,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            String defaultImage =
                "https://ui-avatars.com/api/?name=${user['firstName']}";

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 75,
                        height: 75,
                        color: Colors.grey[200],
                        child: Image.network(
                          user["profile"] != null
                              ? user["profile"]
                              : defaultImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            user["address"] != null
                                ? "${user['address']}"
                                : "Belum ada lokasi.",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      child: Icon(Icons.wechat_rounded,
                          size: 50, color: memerahtua),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RoomsPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: bata, //Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${user['firstName']}  ",
                            style: TextStyle(fontSize: 25, color: whiteColor),
                          ),
                          Text(
                            "${user['lastName']}",
                            style: TextStyle(fontSize: 25, color: whiteColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "${user['job']}",
                            style: TextStyle(
                              fontSize: 20,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            " - ${user['nip']}",
                            style: TextStyle(
                              fontSize: 20,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: shadow, //Colors.grey[200],
                  ),
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: controller.streamTodayPresence(),
                    builder: (context, snapToday) {
                      if (snapToday.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      Map<String, dynamic>? dataToday = snapToday.data?.data();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text("Masuk"),
                              Text(dataToday?["masuk"] == null
                                  ? "-"
                                  : "${DateFormat.jms().format(DateTime.parse(dataToday!['masuk']['date']))}"),
                            ],
                          ),
                          Container(
                            width: 2,
                            height: 40,
                            color: hitam, //Colors.grey,
                          ),
                          Column(
                            children: [
                              const Text("Keluar"),
                              Text(dataToday?["keluar"] == null
                                  ? "-"
                                  : "${DateFormat.jms().format(DateTime.parse(dataToday!['keluar']['date']))}"),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Divider(
                  color: bata,
                  thickness: 2,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Last 5 days",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.ALL_PRESENSI),
                      child: Text(
                        "See more",
                        style: TextStyle(color: bata),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamLastPresence(),
                  builder: (context, snapPresence) {
                    if (snapPresence.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapPresence.data?.docs.length == 0 ||
                        snapPresence.data == null) {
                      return const SizedBox(
                        height: 150,
                        child: Center(
                          child: Text("Belum ada history presensi."),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapPresence.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            snapPresence.data!.docs[index].data();

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Material(
                            color: const Color.fromARGB(103, 100, 15, 15),
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Masuk",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${DateFormat.yMMMEd().format(DateTime.parse(data['date']))}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(data['masuk']?['date'] == null
                                        ? "-"
                                        : "${DateFormat.jms().format(DateTime.parse(data['masuk']!['date']))}"),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Keluar",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(data['keluar']?['date'] == null
                                        ? "-"
                                        : "${DateFormat.jms().format(DateTime.parse(data['keluar']!['date']))}"),
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
              ],
            );
          } else {
            return const Center(
              child: Text("Tidak dapat memuat database user."),
            );
          }
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        backgroundColor: bata,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.fingerprint, title: 'Add'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
