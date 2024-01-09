import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => HomeController(parser: Get.find()),
    );
  }
}
