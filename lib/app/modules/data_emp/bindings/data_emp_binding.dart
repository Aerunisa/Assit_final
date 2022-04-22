import 'package:get/get.dart';

import '../controllers/data_emp_controller.dart';

class DataEmpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataEmpController>(
      () => DataEmpController(),
    );
  }
}
