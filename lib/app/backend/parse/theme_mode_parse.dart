import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';

class ThemeModeParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ThemeModeParser(
      {required this.apiService, required this.sharedPreferencesManager});

  bool getSavedTheme() {
    return sharedPreferencesManager.getBool('theme');
  }

  void saveTheme(bool theme) {
    sharedPreferencesManager.putBool('theme', theme);
  }
}
