import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/tabs_controller.dart';
import 'package:ultimate_news/app/view/home.dart';
import 'package:ultimate_news/app/view/search.dart';
import 'package:ultimate_news/app/view/video.dart';

class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({super.key});

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  final List<Widget> _widgetOptions = const <Widget>[
    HomeScreen(),
    VideoScreen(),
    SearchScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomTabsController>(builder: (value) {
      return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: value.pageController,
          children: _widgetOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: value.homeTitle.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.play_circle_fill_outlined),
              label: value.videoTitle.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search_outlined),
              label: value.searchTitle.tr,
            ),
          ],
          currentIndex: value.selectedIndex,
          showUnselectedLabels: true,
          onTap: value.onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      );
    });
  }
}
