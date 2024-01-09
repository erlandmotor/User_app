import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/models/news_model.dart';
import 'package:ultimate_news/app/backend/parse/video_parse.dart';
import 'package:ultimate_news/app/util/constant.dart';

class VideoController extends GetxController implements GetxService {
  final VideoParser parser;

  String languageCode = AppConstants.defaultLanguageApp;
  List<NewsModel> _news = <NewsModel>[];
  List<NewsModel> get news => _news;
  bool newsCalled = false;

  double defaultTitleSize = AppConstants.defaultTitleSize;
  double defaultDescriptionSize = AppConstants.defaultDescriptionSize;
  double defaultContentSize = AppConstants.defaultContentSize;

  final BannerAd myBanner = BannerAd(
    adUnitId: Platform.isAndroid
        ? AppConstants.androidBannerId
        : AppConstants.ioSBannerId,
    size: AdSize.fullBanner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  VideoController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    myBanner.dispose();
    myBanner.load();
    languageCode = parser.getLanguagesCode();
    defaultTitleSize = parser.getTitleSize();
    defaultDescriptionSize = parser.getDescriptionsSize();
    defaultContentSize = parser.getContentSize();
    getVideos();
  }

  Future<void> getVideos() async {
    newsCalled = false;
    Response response = await parser.getVideoNews();
    newsCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      _news = [];
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
        NewsModel data = NewsModel.fromJson(order);
        _news.add(data);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateScreenAppearance() {
    defaultTitleSize = parser.getTitleSize();
    defaultDescriptionSize = parser.getDescriptionsSize();
    defaultContentSize = parser.getContentSize();
    update();
  }
}
