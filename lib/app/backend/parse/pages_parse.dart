import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/util/constant.dart';

class PagesParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  PagesParser(
      {required this.apiService, required this.sharedPreferencesManager});

  Future<Response> getContentById(var id) async {
    return await apiService.postPublic(AppConstants.pageContent, {'id': id});
  }
}
