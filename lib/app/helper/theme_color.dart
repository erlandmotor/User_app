import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/util/theme.dart';

class ThemeColorsHelper {
  static Color getPrimary() {
    return Get.isDarkMode ? ThemeProvider.appColor : ThemeProvider.blackColor;
  }

  static Color getFontColor() {
    return Get.isDarkMode ? ThemeProvider.whiteColor : ThemeProvider.blackColor;
  }

  static Color getGrayColor() {
    return Get.isDarkMode ? ThemeProvider.whiteColor : ThemeProvider.greyColor;
  }

  static Color getTextColor() {
    return Get.isDarkMode ? ThemeProvider.whiteColor : ThemeProvider.blackColor;
  }

  static Color getBackgroundColor() {
    return Get.isDarkMode ? ThemeProvider.blackColor : ThemeProvider.whiteColor;
  }

  static Color getShadeColor() {
    return Get.isDarkMode
        ? ThemeProvider.whiteColor
        : ThemeProvider.greyColor.shade300;
  }
}
