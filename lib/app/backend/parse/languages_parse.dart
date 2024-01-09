import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';

class LanguagesParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  LanguagesParser(
      {required this.apiService, required this.sharedPreferencesManager});

  String getLanguagesCode() {
    return sharedPreferencesManager.getString('language') ?? 'en';
  }

  void saveLanguage(String code) {
    sharedPreferencesManager.putString('language', code);
  }
}
