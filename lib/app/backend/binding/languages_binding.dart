import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/languages_controller.dart';

class LanguagesBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => LanguagesController(parser: Get.find()),
    );
  }
}
