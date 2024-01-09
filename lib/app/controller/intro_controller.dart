import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/parse/intro_parse.dart';
import 'package:ultimate_news/app/controller/theme_mode_controller.dart';
import 'package:ultimate_news/app/helper/router.dart';

class IntroController extends GetxController implements GetxService {
  final IntroParser parser;
  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;
  bool _isSwitched = Get.find<ThemeModeController>().darkTheme;
  bool get isSwitched => _isSwitched;
  IntroController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    debugPrint('MODE =${Get.isDarkMode}');
  }

  void saveLanguage(String code) {
    parser.saveLanguage(code);
  }

  void toggleSwitch(bool value) {
    if (_isSwitched == false) {
      _isSwitched = true;
      Get.find<ThemeModeController>().toggleTheme();
      update();
    } else {
      _isSwitched = false;
      Get.find<ThemeModeController>().toggleTheme();
      update();
    }
    // debugPrint(currentIndex.toString());
    if (currentIndex == 3) {
      carouselController.previousPage();
    } else {
      carouselController.nextPage();
    }
  }

  void updateIndex(int index) {
    debugPrint(Get.isDarkMode.toString());
    currentIndex = index;
    update();
  }

  void onDonePress() {
    Get.offAllNamed(AppRouter.getTabsRoutes());
  }
}
