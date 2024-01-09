import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/models/banners_model.dart';
import 'package:ultimate_news/app/backend/models/categories_model.dart';
import 'package:ultimate_news/app/backend/models/news_model.dart';
import 'package:ultimate_news/app/backend/parse/home_parse.dart';
import 'package:ultimate_news/app/controller/comments_controller.dart';
import 'package:ultimate_news/app/controller/details_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/util/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final HomeParser parser;

  late TabController tabController;
  List<CategoriesModel> _categories = <CategoriesModel>[];
  List<CategoriesModel> get categories => _categories;

  List<BannersModel> _banners = <BannersModel>[];
  List<BannersModel> get banners => _banners;

  List<NewsModel> _news = <NewsModel>[];
  List<NewsModel> get news => _news;

  bool categoriesCalled = false;
  bool newsCalled = false;
  bool loadMore = false;
  int activeIndex = 0;
  int? cateId = 0;
  var lastLimit = 1.obs;

  String languageCode = AppConstants.defaultLanguageApp;

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
  HomeController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    myBanner.dispose();
    myBanner.load();
    languageCode = parser.getLanguagesCode();
    defaultTitleSize = parser.getTitleSize();
    defaultDescriptionSize = parser.getDescriptionsSize();
    defaultContentSize = parser.getContentSize();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    categoriesCalled = false;
    Response response = await parser.getAllCategories();
    categoriesCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      _categories = [];
      body.forEach((order) {
        if (order['translations'] != null) {
          List<dynamic> translations = jsonDecode(order['translations']);
          List outputList =
              translations.where((o) => o['code'] == languageCode).toList();
          if (outputList.isNotEmpty && outputList.isNotEmpty) {
            order['name'] = outputList[0]['title'];
          }
        }
        CategoriesModel cateData = CategoriesModel.fromJson(order);
        _categories.add(cateData);
      });
      if (_categories.isNotEmpty) {
        debugPrint('ok');
        activeIndex = 0;
        cateId = _categories[activeIndex].id;
        getBanners();
        getNewsById();
        tabController = TabController(length: _categories.length, vsync: this);
        tabController.addListener(() {
          _news = [];
          activeIndex = tabController.index;
          cateId = _categories[activeIndex].id;
          lastLimit = 1.obs;
          getNewsById();
          // myBanner.dispose();
          // myBanner.load();
          update();
        });
      }

      // print('categories lendth' + _categories.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getBanners() async {
    Response response = await parser.getBanners();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      _banners = [];
      body.forEach((order) {
        if (order['extra_field'] != null) {
          dynamic extraField = jsonDecode(order['extra_field']);
          List<dynamic> translations = extraField['translation'];
          List outputList =
              translations.where((o) => o['code'] == languageCode).toList();
          if (outputList.isNotEmpty && outputList.isNotEmpty) {
            order['text'] = outputList[0]['title'];
          }
        }
        BannersModel data = BannersModel.fromJson(order);
        _banners.add(data);
      });
    } else {
      categoriesCalled = true;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getNewsById() async {
    newsCalled = false;
    Response response =
        await parser.getNewsById(cateId as int, lastLimit.value);
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
        _news.add(data);
      });
      loadMore = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void increment() {
    loadMore = true;
    lastLimit = lastLimit++;
    update();
    getNewsById();
  }

  void navigateDetails(int id, String slugs) {
    Get.delete<DetailsController>(force: true);

    Get.toNamed(AppRouter.getDetailsRoutes(),
        arguments: [id.toString(), slugs.toString()], preventDuplicates: false);
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
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else {
      Get.toNamed(AppRouter.getLoginRoutes());
    }
  }

  Future<void> saveNews(NewsModel data) async {
    if (parser.haveAccount() == true && data.haveSaved == false) {
      Response response = await parser.saveNews(data.id);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["data"];
        if (body['id'] != null && body['id'] != '') {
          data.haveSaved = true;
          update();
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
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else {
      Get.toNamed(AppRouter.getLoginRoutes());
    }
  }

  Future<void> hardRefresh() async {
    lastLimit = 1.obs;
    _news = [];
    await getNewsById();
  }

  Future<void> share(NewsModel data) async {
    await FlutterShare.share(
        title: data.title.toString(),
        text: data.shortDescriptions.toString(),
        linkUrl: Environments.websiteURL,
        chooserTitle: 'Share'.tr);
  }

  void openComments(NewsModel data) {
    Get.delete<CommentsController>(force: true);
    Get.toNamed(AppRouter.getCommentsRoute(),
        arguments: [data.id.toString(), data.urlSlugs.toString()],
        preventDuplicates: false);
  }

  void openBannerRoutes(data) {
    Get.delete<DetailsController>(force: true);

    Get.toNamed(AppRouter.getDetailsRoutes(),
        arguments: [data.value.toString(), data.text.toString()],
        preventDuplicates: false);
  }

  void launchURL(url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void updateScreenAppearance() {
    debugPrint('updateScreenAppearance');
    defaultTitleSize = parser.getTitleSize();
    defaultDescriptionSize = parser.getDescriptionsSize();
    defaultContentSize = parser.getContentSize();
    update();
  }
}
