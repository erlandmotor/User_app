import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/models/news_model.dart';
import 'package:ultimate_news/app/backend/parse/details_parse.dart';
import 'package:ultimate_news/app/controller/comments_controller.dart';
import 'package:ultimate_news/app/controller/home_controller.dart';
import 'package:ultimate_news/app/controller/single_video_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/util/constant.dart';

class DetailsController extends GetxController implements GetxService {
  final DetailsParser parser;
  NewsModel _news = NewsModel();
  NewsModel get news => _news;

  List<NewsModel> _related = <NewsModel>[];
  List<NewsModel> get related => _related;

  bool categoriesCalled = false;

  bool haveLiked = false;
  bool haveSaved = false;
  var newsId = '';
  String languageCode = AppConstants.defaultLanguageApp;
  String plainText = '';

  // Speech
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 1.0;
  double pitch = 1.0;
  double androidRate = 1.0;
  double iosRate = 0.5;
  bool isCurrentLanguageInstalled = false;

  // TtsState ttsState = TtsState.stopped;

  // get isPlaying => ttsState == TtsState.playing;
  // get isStopped => ttsState == TtsState.stopped;
  // get isPaused => ttsState == TtsState.paused;
  // get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  String currentLanguageForSpeech = '';
  // Speech

  double defaultTitleSize = AppConstants.defaultTitleSize;
  double defaultDescriptionSize = AppConstants.defaultDescriptionSize;
  double defaultContentSize = AppConstants.defaultContentSize;

  bool isLoaded = false;

  InterstitialAd? interstitialAd;
  DetailsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    defaultTitleSize = parser.getTitleSize();
    defaultDescriptionSize = parser.getDescriptionsSize();
    defaultContentSize = parser.getContentSize();
    languageCode = parser.getLanguagesCode();
    currentLanguageForSpeech = AppConstants.languages
        .firstWhere((element) => element.languageCode == languageCode)
        .tts;
    var id = Get.arguments[0];
    newsId = id.toString();
    // newsId = 5.toString();
    debugPrint(newsId);

    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? AppConstants.androidInterId
            : AppConstants.iosInterId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            isLoaded = true;
            interstitialAd = ad;
            debugPrint('interstitial loaded');
            update();
          },
          onAdFailedToLoad: (error) {
            debugPrint('interstitial Ad failed to load ;');
          },
        ));

    initTts();
    getBySlugs();
  }

  Future<void> getTtsLanguages() async {
    await flutterTts.getLanguages.then((value) => debugPrint(value.toString()));
  }
  // Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      debugPrint("Playing");
      // ttsState = TtsState.playing;
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        debugPrint("TTS Initialized");
      });
    }

    flutterTts.setCompletionHandler(() {
      debugPrint("Complete");
      // ttsState = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
      debugPrint("Cancel");
      // ttsState = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      debugPrint("Paused");
      // ttsState = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      debugPrint("Continued");
      // ttsState = TtsState.continued;
    });

    flutterTts.setErrorHandler((msg) {
      debugPrint("error: $msg");
      // ttsState = TtsState.stopped;
    });
    flutterTts.setLanguage(currentLanguageForSpeech);
    getTtsLanguages();
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      debugPrint(voice.toString());
    }
  }

  Future speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(Platform.isAndroid ? androidRate : iosRate);
    await flutterTts.setPitch(pitch);

    if (plainText.isNotEmpty) {
      await flutterTts.speak(plainText);
    }
  }

  Future stop() async {
    await flutterTts.stop();
    // if (result == 1) ttsState = TtsState.stopped;
    update();
  }

  Future pause() async {
    await flutterTts.pause();
    // if (result == 1) ttsState = TtsState.paused;
    update();
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      debugPrint(engine);
    }
  }

  Future<void> getBySlugs() async {
    Response response = await parser.getNewsById(newsId);
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      haveLiked = body['haveLiked'];
      haveSaved = body['haveSaved'];
      if (body['translations'] != null) {
        List<dynamic> translations = jsonDecode(body['translations']);
        List outputList =
            translations.where((o) => o['code'] == languageCode).toList();
        if (outputList.isNotEmpty && outputList.isNotEmpty) {
          body['title'] = outputList[0]['title'];
          body['short_descriptions'] = outputList[0]['short_description'];
          body['content'] = outputList[0]['content'];
        }
      }
      NewsModel data = NewsModel.fromJson(body);
      _news = data;
      plainText = removeAllHtmlTags(_news.content!);
      categoriesCalled = true;

      Future.delayed(const Duration(seconds: 5), () {
        debugPrint('===================$isLoaded');
        if (isLoaded) {
          debugPrint('load it');
          interstitialAd!.show();
        }
      });
      getRelate(_news.cateId.toString());
    } else {
      categoriesCalled = true;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getRelate(String id) async {
    Response response = await parser.getRelated(id);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      _related = [];
      body.forEach((order) {
        if (order['translations'] != null) {
          List<dynamic> translations = jsonDecode(order['translations']);
          List outputList =
              translations.where((o) => o['code'] == languageCode).toList();
          if (outputList.isNotEmpty && outputList.isNotEmpty) {
            order['title'] = outputList[0]['title'];
            order['short_descriptions'] = outputList[0]['short_description'];
          }
        }

        if (order['cate_translations'] != null) {
          List<dynamic> cateTranslations =
              jsonDecode(order['cate_translations']);
          List cateOutputList =
              cateTranslations.where((o) => o['code'] == languageCode).toList();
          if (cateOutputList.isNotEmpty && cateOutputList.isNotEmpty) {
            order['cate_name'] = cateOutputList[0]['title'];
          }
        }
        NewsModel data = NewsModel.fromJson(order);
        _related.add(data);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void openComments(NewsModel data) {
    Get.delete<CommentsController>(force: true);
    Get.toNamed(AppRouter.getCommentsRoute(),
        arguments: [data.id.toString(), data.urlSlugs.toString()],
        preventDuplicates: false);
  }

  void openCommentsCurrent() {
    Get.delete<CommentsController>(force: true);
    Get.toNamed(AppRouter.getCommentsRoute(),
        arguments: [news.id.toString(), news.urlSlugs.toString()],
        preventDuplicates: false);
  }

  Future<void> saveLikes(NewsModel data) async {
    if (parser.haveAccount() == true && data.haveLiked == false) {
      Response response = await parser.saveLikes(data.id);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        if (body['id'] != null && body['id'] != '') {
          data.haveLiked = true;
          update();
          Get.find<HomeController>().getAllCategories();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else if (parser.haveAccount() == true && data.haveLiked == true) {
      Response response = await parser.deleteLikes(data.id);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        if (body['id'] != null && body['id'] != '') {
          data.haveLiked = false;
          update();
          Get.find<HomeController>().getAllCategories();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else {
      Get.toNamed(AppRouter.getLoginRoutes());
    }
  }

  Future<void> saveLikesCurrent() async {
    if (parser.haveAccount() == true && haveLiked == false) {
      Response response = await parser.saveLikes(newsId);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        if (body['id'] != null && body['id'] != '') {
          haveLiked = true;
          update();
          Get.find<HomeController>().getAllCategories();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else if (parser.haveAccount() == true && haveLiked == true) {
      Response response = await parser.deleteLikes(newsId);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        if (body['id'] != null && body['id'] != '') {
          haveLiked = false;
          update();
          Get.find<HomeController>().getAllCategories();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else {
      Get.toNamed(AppRouter.getLoginRoutes());
    }
  }

  Future<void> saveNews(data) async {
    if (parser.haveAccount() == true && data.haveSaved == false) {
      Response response = await parser.saveNews(data.id);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        if (body['id'] != null && body['id'] != '') {
          data.haveSaved = true;
          update();
          Get.find<HomeController>().getAllCategories();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else if (parser.haveAccount() == true && data.haveSaved == true) {
      Response response = await parser.deletSaved(data.id);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        if (body['id'] != null && body['id'] != '') {
          data.haveSaved = false;
          update();
          Get.find<HomeController>().getAllCategories();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else {
      Get.toNamed(AppRouter.getLoginRoutes());
    }
  }

  Future<void> saveNewsCurrent() async {
    if (parser.haveAccount() == true && haveSaved == false) {
      Response response = await parser.saveNews(newsId);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        if (body['id'] != null && body['id'] != '') {
          haveSaved = true;
          update();
          Get.find<HomeController>().getAllCategories();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else if (parser.haveAccount() == true && haveSaved == true) {
      Response response = await parser.deletSaved(newsId);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        if (body['id'] != null && body['id'] != '') {
          haveSaved = false;
          update();
          Get.find<HomeController>().getAllCategories();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else {
      Get.toNamed(AppRouter.getLoginRoutes());
    }
  }

  Future<void> share(data) async {
    await FlutterShare.share(
        title: data.title.toString(),
        text: data.shortDescriptions.toString(),
        linkUrl: Environments.websiteURL,
        chooserTitle: 'Share'.tr);
  }

  Future<void> shareCurrent() async {
    await FlutterShare.share(
        title: _news.title.toString(),
        text: _news.shortDescriptions.toString(),
        linkUrl: Environments.websiteURL,
        chooserTitle: 'Share'.tr);
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  void openSingleVideoScreen() {
    Get.delete<SingleVideoController>(force: true);
    Get.toNamed(AppRouter.getSingleVideoRoutes(), arguments: [
      news.videoUrl.toString(),
      news.id.toString(),
      news.urlSlugs.toString(),
      news.title.toString(),
      news.shortDescriptions.toString()
    ]);
  }
}
