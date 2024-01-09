import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => LoginController(parser: Get.find()),
    );
  }
}
