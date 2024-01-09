import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => AppSearchController(parser: Get.find()),
    );
  }
}
