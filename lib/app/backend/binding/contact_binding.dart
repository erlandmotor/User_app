import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/contact_controller.dart';

class ContactBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => ContactController(parser: Get.find()),
    );
  }
}
