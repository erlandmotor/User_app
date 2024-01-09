import 'dart:convert';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/models/saved_news_model.dart';
import 'package:ultimate_news/app/backend/parse/saved_news_parse.dart';
import 'package:ultimate_news/app/controller/comments_controller.dart';
import 'package:ultimate_news/app/controller/details_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/util/constant.dart';

class SavedNewsController extends GetxController implements GetxService {
  final SavedNewsParser parser;
  List<SavedNewsModel> _news = <SavedNewsModel>[];
  List<SavedNewsModel> get news => _news;
  String languageCode = AppConstants.defaultLanguageApp;
  bool apiCalled = false;

  double defaultTitleSize = AppConstants.defaultTitleSize;
  double defaultDescriptionSize = AppConstants.defaultDescriptionSize;
  double defaultContentSize = AppConstants.defaultContentSize;
  SavedNewsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    languageCode = parser.getLanguagesCode();
    defaultTitleSize = parser.getTitleSize();
    defaultDescriptionSize = parser.getDescriptionsSize();
    defaultContentSize = parser.getContentSize();
    getSavedNews();
  }

  Future<void> getSavedNews() async {
    Response response = await parser.getMySavedNews();
    apiCalled = true;
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

        SavedNewsModel data = SavedNewsModel.fromJson(order);
        _news.add(data);
      });
    } else {
      parser.clearAccount();
      ApiChecker.checkApi(response);
    }
    update();
  }

  void navigateDetails(SavedNewsModel data) {
    Get.delete<DetailsController>(force: true);

    Get.toNamed(AppRouter.getDetailsRoutes(),
        arguments: [data.newsId.toString(), data.urlSlugs.toString()],
        preventDuplicates: false);
  }

  Future<void> share(SavedNewsModel data) async {
    await FlutterShare.share(
        title: data.title.toString(),
        text: data.shortDescriptions.toString(),
        linkUrl: Environments.websiteURL,
        chooserTitle: 'Share'.tr);
  }

  void openComments(SavedNewsModel data) {
    Get.delete<CommentsController>(force: true);
    Get.toNamed(AppRouter.getCommentsRoute(),
        arguments: [data.newsId.toString(), data.urlSlugs.toString()],
        preventDuplicates: false);
  }

  Future<void> saveLikes(SavedNewsModel data) async {
    if (parser.haveAccount() == true && data.haveLiked == false) {
      Response response = await parser.saveLikes(data.newsId);
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
      Response response = await parser.deleteLikes(data.newsId);
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

  Future<void> saveNews(SavedNewsModel data) async {
    Response response = await parser.deletSaved(data.newsId);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body['id'] != null && body['id'] != '') {
        getSavedNews();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
