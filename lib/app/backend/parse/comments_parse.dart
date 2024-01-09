import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/util/constant.dart';

class CommentsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  CommentsParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> saveComments(dynamic param) async {
    return await apiService.postPrivate(AppConstants.saveComments, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getComments(var id) async {
    return await apiService.postPublic(AppConstants.getComments, {'id': id});
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  bool haveAccount() {
    return sharedPreferencesManager.getString('token') != '' &&
            sharedPreferencesManager.getString('token') != null
        ? true
        : false;
  }
}
