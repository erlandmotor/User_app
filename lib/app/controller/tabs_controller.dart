import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/parse/tabs_parse.dart';
import 'package:flutter/material.dart';

class BottomTabsController extends GetxController implements GetxService {
  final TabsParser parser;
  String homeTitle = 'Home';
  String videoTitle = 'Videos';
  String searchTitle = 'Search';

  late PageController pageController;
  int selectedIndex = 0;
  BottomTabsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex, keepPage: true);
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  void updateScreen() {
    homeTitle = 'Home';
    videoTitle = 'Videos';
    searchTitle = 'Search';
    // onItemTapped(1);
    update();
  }
}
