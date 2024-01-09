import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/account_controller.dart';

class AccountBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => AccountController(parser: Get.find()),
    );
  }
}
