import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/models/search_news_model.dart';
import 'package:ultimate_news/app/backend/parse/search_parse.dart';
import 'package:ultimate_news/app/util/constant.dart';

class AppSearchController extends GetxController implements GetxService {
  final SearchParser parser;

  List<SearchResultModel> _news = <SearchResultModel>[];
  List<SearchResultModel> get news => _news;
  bool isEmpty = true;
  String languageCode = AppConstants.defaultLanguageApp;
  TextEditingController searchController = TextEditingController();

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

  AppSearchController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    myBanner.dispose();
    myBanner.load();
    languageCode = parser.getLanguagesCode();
    defaultTitleSize = parser.getTitleSize();
    defaultDescriptionSize = parser.getDescriptionsSize();
    defaultContentSize = parser.getContentSize();
  }

  searchNews(String name) {
    if (name.isNotEmpty && name != '') {
      getSearchResult(name);
    } else {
      _news = [];
      isEmpty = true;
      update();
    }
  }

  Future<void> getSearchResult(String query) async {
    Response response = await parser.getSearchResult(query);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["news"];
      _news = [];
      isEmpty = false;
      body.forEach((order) {
        if (order['translations'] != null) {
          List<dynamic> translations = jsonDecode(order['translations']);
          List outputList =
              translations.where((o) => o['code'] == languageCode).toList();
          if (outputList.isNotEmpty && outputList.isNotEmpty) {
            order['title'] = outputList[0]['title'];
          }
        }
        SearchResultModel data = SearchResultModel.fromJson(order);
        _news.add(data);
      });
    } else {
      isEmpty = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateScreenAppearance() {
    debugPrint('updateScreenAppearance');
    defaultTitleSize = parser.getTitleSize();
    defaultDescriptionSize = parser.getDescriptionsSize();
    defaultContentSize = parser.getContentSize();
    update();
  }
}
