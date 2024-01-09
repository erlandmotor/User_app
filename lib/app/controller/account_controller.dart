import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/parse/account_parse.dart';
import 'package:ultimate_news/app/controller/home_controller.dart';
import 'package:ultimate_news/app/controller/tabs_controller.dart';
import 'package:ultimate_news/app/controller/theme_mode_controller.dart';
import 'package:ultimate_news/app/helper/router.dart';

class AccountController extends GetxController implements GetxService {
  final AccountParser parser;
  String userName = '';
  bool haveAccount = false;
  bool _isSwitched = Get.find<ThemeModeController>().darkTheme;
  bool get isSwitched => _isSwitched;
  AccountController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    if (parser.haveNames()) {
      haveAccount = true;
      userName = '${parser.getFirstName()} ${parser.getLastName()}';
    } else {
      haveAccount = false;
    }
    update();
  }

  Future<void> logout() async {
    Response response = await parser.logout();
    if (response.statusCode == 200) {
      parser.clearAccount();
      Get.delete<AccountController>(force: true);
      Get.find<HomeController>().getAllCategories();
      Get.offNamed(AppRouter.getTabsRoutes());
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void toggleSwitch(bool value) {
    if (_isSwitched == false) {
      _isSwitched = true;
      Get.find<ThemeModeController>().toggleTheme();
      update();
    } else {
      _isSwitched = false;
      Get.find<ThemeModeController>().toggleTheme();
      update();
    }
    update();
    Get.find<HomeController>().getAllCategories();
    Get.find<BottomTabsController>().updateScreen();
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
