import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/parse/languages_parse.dart';
import 'package:ultimate_news/app/controller/home_controller.dart';
import 'package:ultimate_news/app/controller/search_controller.dart';
import 'package:ultimate_news/app/controller/video_controller.dart';

class LanguagesController extends GetxController implements GetxService {
  final LanguagesParser parser;
  late String languageCode;

  LanguagesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    languageCode = parser.getLanguagesCode();
  }

  void saveLanguages(String code) {
    languageCode = code;
    var locale = Locale(code.toString());
    Get.updateLocale(locale);
    parser.saveLanguage(code);
    Get.find<HomeController>().languageCode = code;
    Get.find<HomeController>().getAllCategories();

    Get.find<VideoController>().languageCode = code;
    Get.find<VideoController>().getVideos();

    Get.find<AppSearchController>().languageCode = code;
    Get.find<AppSearchController>().isEmpty = true;
  }
}
