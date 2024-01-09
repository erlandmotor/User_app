import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:ultimate_news/app/util/constant.dart';

class AppearanceParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AppearanceParser(
      {required this.apiService, required this.sharedPreferencesManager});

  double getTitleSize() {
    return sharedPreferencesManager.getDouble('titleSize') ??
        AppConstants.defaultTitleSize;
  }

  double getDescriptionsSize() {
    return sharedPreferencesManager.getDouble('descriptionSize') ??
        AppConstants.defaultDescriptionSize;
  }

  double getContentSize() {
    return sharedPreferencesManager.getDouble('contentSize') ??
        AppConstants.defaultContentSize;
  }

  void saveTitleSize(double num) {
    sharedPreferencesManager.putDouble('titleSize', num);
  }

  void saveDescriptionSize(double num) {
    sharedPreferencesManager.putDouble('descriptionSize', num);
  }

  void saveContentSize(double num) {
    sharedPreferencesManager.putDouble('contentSize', num);
  }
}
