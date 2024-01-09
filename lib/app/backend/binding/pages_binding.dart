import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/pages_controller.dart';

class PagesBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => PagesController(parser: Get.find()),
    );
  }
}
