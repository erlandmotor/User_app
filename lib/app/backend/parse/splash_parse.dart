import 'dart:io';

import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/util/constant.dart';
import 'package:device_info_plus/device_info_plus.dart';

class SplashParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SplashParser(
      {required this.apiService, required this.sharedPreferencesManager});

  Future<bool> initAppSettings() {
    return Future.value(true);
  }

  bool showSplash() {
    return sharedPreferencesManager.getBool('intro');
  }

  void setIntro(bool intro) {
    sharedPreferencesManager.putBool('intro', intro);
  }

  String getLanguagesCode() {
    return sharedPreferencesManager.getString('language') ?? 'en';
  }

  bool findMode() {
    return sharedPreferencesManager.getBool('theme');
  }

  void saveTheme() {
    sharedPreferencesManager.putBool('theme', false);
  }

  Future<Response> saveDeviceToken(token) async {
    String? deviceId = await _getId();
    Response response = await apiService.postPublic(AppConstants.saveToken,
        {'device_id': deviceId, 'fcm_token': token, 'status': '1'});
    return response;
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }
}
