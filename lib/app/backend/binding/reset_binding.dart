import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/reset_controller.dart';

class ResetBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => ResetController(parser: Get.find()),
    );
  }
}
