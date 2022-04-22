import 'package:asistencia_fix/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asistencia_fix/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';
import '../../../controllers/page_index_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageC = Get.find<PageIndexController>();

  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'PROFILE',
          style: TextStyle(
              color: maroonColor, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasData) {
            Map<String, dynamic> user = snap.data!.data()!;
            String defaultImage =
                "https://ui-avatars.com/api/?name=${user['firstName']}";
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          user["profile"] != null
                              ? user["profile"] != ""
                                  ? user["profile"]
                                  : defaultImage
                              : defaultImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${user['firstName'].toString().toUpperCase()}  ",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "${user['lastName'].toString().toUpperCase()}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "${user['email']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: bata,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  onTap: () => Get.toNamed(
                    Routes.UPDATE_PROFILE,
                    arguments: user,
                  ),
                  leading: Icon(
                    Icons.person,
                    color: bata,
                  ),
                  title: const Text("Update Profile"),
                ),
                ListTile(
                  onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                  leading: Icon(
                    Icons.vpn_key,
                    color: bata,
                  ),
                  title: const Text("Update Password"),
                ),
                if (user["role"] == "admin")
                  ListTile(
                    onTap: () => Get.toNamed(Routes.ADD_PEGAWAI),
                    leading: Icon(
                      Icons.person_add,
                      color: bata,
                    ),
                    title: const Text("Add New Employee"),
                  ),
                if (user["role"] == "admin")
                  ListTile(
                    onTap: () => Get.toNamed(Routes.DATA_EMPLOY),
                    leading: Icon(
                      Icons.group,
                      color: bata,
                    ),
                    title: const Text("All Data Employee"),
                  ),
                if (user["role"] == "admin")
                  ListTile(
                    onTap: () => Get.toNamed(Routes.DATA_ADMIN),
                    leading: Icon(
                      Icons.account_tree_outlined,
                      color: bata,
                    ),
                    title: const Text("All Data Presence"),
                  ),
                ListTile(
                  onTap: () => controller.logout(),
                  leading: Icon(
                    Icons.logout,
                    color: bata,
                  ),
                  title: const Text("Logout"),
                ),
              ],
            );
          } else {
            return const Center(
              child: const Text("Tidak dapat memuat data user."),
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
