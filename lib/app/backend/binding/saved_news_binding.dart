import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/saved_news_controller.dart';

class SavedNewsBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => SavedNewsController(parser: Get.find()),
    );
  }
}
