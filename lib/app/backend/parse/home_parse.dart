import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/util/constant.dart';

class HomeParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  HomeParser(
      {required this.sharedPreferencesManager, required this.apiService});

  String getLanguagesCode() {
    return sharedPreferencesManager.getString('language') ?? 'en';
  }

  Future<Response> getAllCategories() async {
    return await apiService.getPublic(AppConstants.allCategories);
  }

  Future<Response> getBanners() async {
    return await apiService.getPublic(AppConstants.banners);
  }

  Future<Response> getNewsById(int id, int limit) async {
    limit = limit * 5;
    return await apiService.postPublic(AppConstants.newsByCateId, {
      'id': id,
      'limit': limit,
      'uid': sharedPreferencesManager.getString('uid')
    });
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
