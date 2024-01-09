import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/register_controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => RegisterController(parser: Get.find()),
    );
  }
}
