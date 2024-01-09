import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/details_controller.dart';

class DetailsBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => DetailsController(parser: Get.find()),
    );
  }
}
