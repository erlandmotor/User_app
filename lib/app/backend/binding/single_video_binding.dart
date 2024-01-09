import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/single_video_controller.dart';

class SingleVideoBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => SingleVideoController(parser: Get.find()),
    );
  }
}
