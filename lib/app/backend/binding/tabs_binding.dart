import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/home_controller.dart';
import 'package:ultimate_news/app/controller/search_controller.dart';
import 'package:ultimate_news/app/controller/tabs_controller.dart';
import 'package:ultimate_news/app/controller/theme_mode_controller.dart';
import 'package:ultimate_news/app/controller/video_controller.dart';

class TabsBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => BottomTabsController(parser: Get.find()),
    );
    Get.lazyPut(() => HomeController(parser: Get.find()));
    Get.lazyPut(() => VideoController(parser: Get.find()));
    Get.lazyPut(() => AppSearchController(parser: Get.find()));
    Get.lazyPut(() => ThemeModeController(parser: Get.find()));
  }
}
