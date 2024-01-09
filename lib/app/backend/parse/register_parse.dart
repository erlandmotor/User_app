import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/util/constant.dart';

class RegisterParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  RegisterParser(
      {required this.apiService, required this.sharedPreferencesManager});

  Future<Response> registerPost(dynamic param) async {
    return await apiService.postPublic(AppConstants.register, param);
  }

  void saveInfo(String token, String uid, String firstName, String lastName) {
    sharedPreferencesManager.putString('token', token);
    sharedPreferencesManager.putString('uid', uid);
    sharedPreferencesManager.putString('firstName', firstName);
    sharedPreferencesManager.putString('lastName', lastName);
  }
}
