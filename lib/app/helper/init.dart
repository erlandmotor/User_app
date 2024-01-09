import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/api/api.dart';
import 'package:ultimate_news/app/backend/parse/account_parse.dart';
import 'package:ultimate_news/app/backend/parse/appearance_parse.dart';
import 'package:ultimate_news/app/backend/parse/comments_parse.dart';
import 'package:ultimate_news/app/backend/parse/contact_parse.dart';
import 'package:ultimate_news/app/backend/parse/details_parse.dart';
import 'package:ultimate_news/app/backend/parse/home_parse.dart';
import 'package:ultimate_news/app/backend/parse/intro_parse.dart';
import 'package:ultimate_news/app/backend/parse/languages_parse.dart';
import 'package:ultimate_news/app/backend/parse/login_parse.dart';
import 'package:ultimate_news/app/backend/parse/pages_parse.dart';
import 'package:ultimate_news/app/backend/parse/register_parse.dart';
import 'package:ultimate_news/app/backend/parse/reset_parse.dart';
import 'package:ultimate_news/app/backend/parse/saved_news_parse.dart';
import 'package:ultimate_news/app/backend/parse/search_parse.dart';
import 'package:ultimate_news/app/backend/parse/single_video_parse.dart';
import 'package:ultimate_news/app/backend/parse/splash_parse.dart';
import 'package:ultimate_news/app/backend/parse/tabs_parse.dart';
import 'package:ultimate_news/app/backend/parse/theme_mode_parse.dart';
import 'package:ultimate_news/app/backend/parse/video_parse.dart';
import 'package:ultimate_news/app/controller/theme_mode_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPref = await SharedPreferences.getInstance();
    Get.put(
      SharedPreferencesManager(sharedPreferences: sharedPref),
      permanent: true,
    );

    Get.lazyPut(() => ApiService(appBaseUrl: Environments.apiBaseURL));

    // Parser LazyLoad
    Get.lazyPut(
        () => HomeParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AccountParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CommentsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ContactParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => DetailsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => IntroParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LanguagesParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LoginParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => PagesParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => RegisterParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ResetParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SavedNewsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SearchParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SplashParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TabsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => VideoParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ThemeModeParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SingleVideoParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AppearanceParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(() => ThemeModeController(parser: Get.find()));
  }
}
