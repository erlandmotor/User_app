import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:ultimate_news/app/util/constant.dart';

class SingleVideoParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SingleVideoParser(
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
}
