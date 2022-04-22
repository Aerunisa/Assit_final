import 'package:get/get.dart';

import '../controllers/data_admin_controller.dart';

class DataAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataAdminController>(
      () => DataAdminController(),
    );
  }
}
