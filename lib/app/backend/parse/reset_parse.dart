import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/util/constant.dart';

class ResetParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ResetParser(
      {required this.apiService, required this.sharedPreferencesManager});

  void saveLanguage(String code) {
    sharedPreferencesManager.putString('language', code);
  }

  Future<Response> sendResetEmail(dynamic param) async {
    return await apiService.postPublic(AppConstants.sendEmailForReset, param);
  }

  Future<Response> verifyOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyOTPRequest, param);
  }

  Future<Response> updatePassword(dynamic param) async {
    return await apiService.postPublic(
        AppConstants.updatePasswordRequest, param);
  }
}
