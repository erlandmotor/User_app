import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/models/languages_model.dart';
import 'package:ultimate_news/app/backend/parse/splash_parse.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashController extends GetxController implements GetxService {
  final SplashParser parser;
  late LanguageModel _defaultLanguage;
  LanguageModel get defaultLanguage => _defaultLanguage;
  bool _firstTimeConnectionCheck = true;
  var defaultCode = 'en';
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  SplashController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    if (parser.findMode() == false) {
      parser.saveTheme();
    }
    FirebaseMessaging.instance.getToken().then((value) async {
      String? token = value;
      Response response = await parser.saveDeviceToken(token);
      debugPrint(response.bodyString);
      debugPrint('/////////////////////////');
      debugPrint(token);
      debugPrint('/////////////////////////');
    });
  }

  Future<bool> initSharedData() {
    return parser.initAppSettings();
  }

  bool showIntro() {
    return parser.showSplash();
  }

  void setIntro(bool intro) {
    parser.setIntro(intro);
  }

  String getLanguageCode() {
    return parser.getLanguagesCode();
  }
}
