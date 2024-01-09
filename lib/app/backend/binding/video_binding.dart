import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/video_controller.dart';

class VideoBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => VideoController(parser: Get.find()),
    );
  }
}
