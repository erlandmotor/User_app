import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/appearance_controller.dart';

class AppearanceBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => AppearanceController(parser: Get.find()),
    );
  }
}
