import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/intro_controller.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/constant.dart';
import 'package:ultimate_news/app/util/theme.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  Widget getLanguages() {
    return PopupMenuButton(
      color: ThemeProvider.whiteColor,
      onSelected: (value) {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: IconButton(
          icon: const Icon(Icons.translate),
          color: ThemeProvider.appColor,
          tooltip: "Save Todo and Retrun to List".tr,
          onPressed: () {
            debugPrint('pressed');
          },
        ),
      ),
      itemBuilder: (context) => AppConstants.languages
          .map((e) => PopupMenuItem<String>(
                value: e.languageCode.toString(),
                onTap: () {
                  var locale = Locale(e.languageCode.toString());
                  Get.updateLocale(locale);
                  Get.find<IntroController>().saveLanguage(e.languageCode);
                },
                child: Text(
                  e.languageName.toString(),
                  style: const TextStyle(
                      color: ThemeProvider.blackColor,
                      fontSize: 14,
                      fontFamily: 'bold'),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        appBar: AppBar(
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Switch(
              onChanged: value.toggleSwitch,
              value: value.isSwitched,
              activeColor: Colors.black26,
              activeTrackColor: Colors.grey,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.black,
            ),
          ),
          backgroundColor: ThemeColorsHelper.getBackgroundColor(),
          actions: <Widget>[getLanguages()],
        ),
        body: CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              value.updateIndex(index);
            },
            height: double.infinity,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: false,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          carouselController: value.carouselController,
          items: [1, 2, 3, 4].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  color: ThemeColorsHelper.getBackgroundColor(),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (i == 1)
                          Column(
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/sliders/1.png',
                                      ),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(
                                      'Get Latest News'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'bold',
                                          fontSize: 20,
                                          color:
                                              ThemeColorsHelper.getFontColor()),
                                    ),
                                  ),
                                  Text(
                                    'Fast and accurate updates on the InitNews News App will ensure that you find the latest news headlines on your finger tips in different 9 languages. The app is built especially for android and iOS devices.'
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ThemeColorsHelper.getFontColor(),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        else if (i == 2)
                          Column(
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/sliders/2.png',
                                      ),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      'Trusted Publishers'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 20,
                                        color: ThemeColorsHelper.getFontColor(),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Get world news, entertainment news, TV & cinema gossips, cricket updates, horoscope, weather, employment news, defense, stock updates & much more'
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: ThemeColorsHelper.getFontColor(),
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          )
                        else if (i == 3)
                          Column(
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/sliders/3.png',
                                      ),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(
                                      'Breaking News'.tr,
                                      style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 20,
                                        color: ThemeColorsHelper.getFontColor(),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Informative stories and features to improve your Lifestyle – Health, Wellness, Fitness, Food and Recipes, Travel and much more.'
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: ThemeColorsHelper.getFontColor(),
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          )
                        else if (i == 4)
                          Column(
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/sliders/4.png',
                                      ),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(
                                      'Instant Notifications'.tr,
                                      style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 20,
                                        color: ThemeColorsHelper.getFontColor(),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Get Latest News Notifications, Get customized content through a recommended stream of news, videos & photos'
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: ThemeColorsHelper.getFontColor(),
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  if (value.currentIndex == 0) {
                    value.onDonePress();
                  } else {
                    value.carouselController.previousPage();
                  }
                },
                child: SizedBox(
                  height: 50,
                  width: 100,
                  child: Center(
                    child: Text(
                      value.currentIndex == 0 ? 'Skip'.tr : 'Previous'.tr,
                      style: TextStyle(
                          fontFamily: 'bold',
                          color: ThemeColorsHelper.getFontColor()),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  if (value.currentIndex == 3) {
                    value.onDonePress();
                  } else {
                    value.carouselController.nextPage();
                  }
                },
                child: SizedBox(
                  height: 50,
                  width: 100,
                  child: Center(
                    child: Text(
                      value.currentIndex == 3 ? 'Get Started'.tr : 'Next'.tr,
                      style: const TextStyle(
                          fontFamily: 'bold', color: ThemeProvider.appColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
