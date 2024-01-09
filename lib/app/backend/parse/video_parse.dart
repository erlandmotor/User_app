import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/util/constant.dart';

class VideoParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  VideoParser(
      {required this.apiService, required this.sharedPreferencesManager});

  Future<Response> getVideoNews() async {
    return await apiService.getPublic(AppConstants.videoNews);
  }

  String getLanguagesCode() {
    return sharedPreferencesManager.getString('language') ?? 'en';
  }

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
