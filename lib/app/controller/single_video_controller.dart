import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/parse/single_video_parse.dart';
import 'package:ultimate_news/app/util/constant.dart';

class SingleVideoController extends GetxController implements GetxService {
  final SingleVideoParser parser;
  String videoURL = '';
  String id = '';
  String slug = '';
  String title = '';
  String shortDescriptions = '';

  double defaultTitleSize = AppConstants.defaultTitleSize;
  double defaultDescriptionSize = AppConstants.defaultDescriptionSize;
  double defaultContentSize = AppConstants.defaultContentSize;
  SingleVideoController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    videoURL = Get.arguments[0];
    id = Get.arguments[1];
    slug = Get.arguments[2];
    title = Get.arguments[3];
    shortDescriptions = Get.arguments[4];
    debugPrint(videoURL);
    defaultTitleSize = parser.getTitleSize();
    defaultDescriptionSize = parser.getDescriptionsSize();
    defaultContentSize = parser.getContentSize();
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
