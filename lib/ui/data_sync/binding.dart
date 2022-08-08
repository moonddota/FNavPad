import 'package:get/get.dart';

import 'logic.dart';

class DataSyncBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataSyncLogic());
  }
}
