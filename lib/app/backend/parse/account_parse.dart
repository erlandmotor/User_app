import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/util/constant.dart';

class AccountParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AccountParser(
      {required this.sharedPreferencesManager, required this.apiService});

  String getFirstName() {
    return sharedPreferencesManager.getString('firstName') ?? '';
  }

  String getLastName() {
    return sharedPreferencesManager.getString('lastName') ?? '';
  }

  bool haveNames() {
    return sharedPreferencesManager.getString('firstName') != '' &&
            sharedPreferencesManager.getString('firstName') != null
        ? true
        : false;
  }

  Future<Response> logout() async {
    return await apiService.logout(
        AppConstants.logout, sharedPreferencesManager.getString('token') ?? '');
  }

  void clearAccount() {
    sharedPreferencesManager.clearKey('firstName');
    sharedPreferencesManager.clearKey('lastName');
    sharedPreferencesManager.clearKey('token');
    sharedPreferencesManager.clearKey('uid');
  }
}
