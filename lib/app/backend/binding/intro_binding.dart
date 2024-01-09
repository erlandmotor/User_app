import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/intro_controller.dart';

class IntroBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => IntroController(parser: Get.find()),
    );
  }
}
