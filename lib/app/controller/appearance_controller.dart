import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/parse/appearance_parse.dart';
import 'package:ultimate_news/app/controller/home_controller.dart';
import 'package:ultimate_news/app/controller/search_controller.dart';
import 'package:ultimate_news/app/controller/video_controller.dart';
import 'package:ultimate_news/app/util/constant.dart';
import 'package:ultimate_news/app/util/toast.dart';

class AppearanceController extends GetxController implements GetxService {
  final AppearanceParser parser;

  double defaultTitleSize = AppConstants.defaultTitleSize;
  double defaultDescriptionSize = AppConstants.defaultDescriptionSize;
  double defaultContentSize = AppConstants.defaultContentSize;
  AppearanceController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    defaultTitleSize = parser.getTitleSize();
    defaultDescriptionSize = parser.getDescriptionsSize();
    defaultContentSize = parser.getContentSize();
    update();
  }

  void updateTitleSize(String type) {
    if (type == 'add') {
      if (defaultTitleSize >= 28) {
        defaultTitleSize = 28;
      } else {
        defaultTitleSize = defaultTitleSize + 1;
      }
      parser.saveTitleSize(defaultTitleSize);
    } else if (type == 'remove') {
      if (defaultTitleSize >= 8) {
        defaultTitleSize = defaultTitleSize - 1;
        parser.saveTitleSize(defaultTitleSize);
      } else {
        showToast('size must be less than or equal to 8');
        defaultTitleSize = 8;
        parser.saveTitleSize(defaultTitleSize);
      }
    }

    update();
    Get.find<HomeController>().updateScreenAppearance();
    Get.find<VideoController>().updateScreenAppearance();
    Get.find<AppSearchController>().updateScreenAppearance();
  }

  void updateDescriptionSize(String type) {
    if (type == 'add') {
      if (defaultDescriptionSize >= 28) {
        defaultDescriptionSize = 28;
      } else {
        defaultDescriptionSize = defaultDescriptionSize + 1;
      }
      parser.saveDescriptionSize(defaultDescriptionSize);
    } else if (type == 'remove') {
      if (defaultDescriptionSize >= 8) {
        defaultDescriptionSize = defaultDescriptionSize - 1;
        parser.saveDescriptionSize(defaultDescriptionSize);
      } else {
        showToast('size must be less than or equal to 8');
        defaultDescriptionSize = 8;
        parser.saveDescriptionSize(defaultDescriptionSize);
      }
    }

    update();
    Get.find<HomeController>().updateScreenAppearance();
    Get.find<VideoController>().updateScreenAppearance();
    Get.find<AppSearchController>().updateScreenAppearance();
  }

  void updateContentSize(String type) {
    if (type == 'add') {
      if (defaultContentSize >= 28) {
        defaultContentSize = 28;
      } else {
        defaultContentSize = defaultContentSize + 1;
      }
      parser.saveContentSize(defaultContentSize);
    } else if (type == 'remove') {
      if (defaultContentSize >= 8) {
        defaultContentSize = defaultContentSize - 1;
        parser.saveContentSize(defaultContentSize);
      } else {
        showToast('size must be less than or equal to 8');
        defaultContentSize = 8;
        parser.saveContentSize(defaultContentSize);
      }
    }

    update();
    Get.find<HomeController>().updateScreenAppearance();
    Get.find<VideoController>().updateScreenAppearance();
    Get.find<AppSearchController>().updateScreenAppearance();
  }
}
