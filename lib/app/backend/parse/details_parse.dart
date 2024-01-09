import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/util/constant.dart';

class DetailsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  DetailsParser(
      {required this.apiService, required this.sharedPreferencesManager});

  Future<Response> getNewsById(String id) async {
    return await apiService.postPublic(AppConstants.getById,
        {'id': id, 'uid': sharedPreferencesManager.getString('uid')});
  }

  Future<Response> getRelated(String id) async {
    return await apiService.postPublic(AppConstants.relatedNews,
        {'id': id, 'uid': sharedPreferencesManager.getString('uid')});
  }

  String getLanguagesCode() {
    return sharedPreferencesManager.getString('language') ?? 'en';
  }

  bool haveAccount() {
    return sharedPreferencesManager.getString('token') != '' &&
            sharedPreferencesManager.getString('token') != null
        ? true
        : false;
  }

  Future<Response> saveLikes(var id) async {
    var param = {
      'news_id': id,
      'uid': sharedPreferencesManager.getString('uid')
    };
    return await apiService.postPrivate(AppConstants.saveLikes, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> deleteLikes(var id) async {
    var param = {
      'news_id': id,
      'uid': sharedPreferencesManager.getString('uid')
    };
    return await apiService.postPrivate(AppConstants.deleteLikes, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> deletSaved(var id) async {
    var param = {
      'news_id': id,
      'uid': sharedPreferencesManager.getString('uid')
    };
    return await apiService.postPrivate(AppConstants.deleteSaved, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> saveNews(var id) async {
    var param = {
      'news_id': id,
      'uid': sharedPreferencesManager.getString('uid')
    };
    return await apiService.postPrivate(AppConstants.saveNews, param,
        sharedPreferencesManager.getString('token') ?? '');
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
