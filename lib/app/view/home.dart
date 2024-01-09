import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:skeletons/skeletons.dart';
import 'package:ultimate_news/app/controller/account_controller.dart';
import 'package:ultimate_news/app/controller/home_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // debugPrint('scrolling');
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        debugPrint('Load More');
        Get.find<HomeController>().increment();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (value) {
      Color fromHex(String hexString) {
        final buffer = StringBuffer();
        if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
        buffer.write(hexString.replaceFirst('#', ''));
        return Color(int.parse(buffer.toString(), radix: 16));
      }

      return value.categoriesCalled
          ? DefaultTabController(
              length: value.categories.length,
              child: Scaffold(
                backgroundColor: ThemeColorsHelper.getBackgroundColor(),
                appBar: AppBar(
                  backgroundColor: ThemeColorsHelper.getBackgroundColor(),
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: const Text(
                    Environments.appName,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'bold',
                        color: ThemeProvider.appColor),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.delete<AccountController>(force: true);
                        Get.toNamed(AppRouter.getAccountRoute());
                      },
                      icon: const Icon(Icons.account_circle_outlined),
                      color: ThemeColorsHelper.getFontColor(),
                    )
                  ],
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(30.0),
                      child: TabBar(
                        controller: value.tabController,
                        isScrollable: true,
                        labelColor: ThemeColorsHelper.getTextColor(),
                        unselectedLabelColor: ThemeColorsHelper.getTextColor(),
                        indicatorColor: ThemeColorsHelper.getTextColor(),
                        labelStyle: TextStyle(
                            fontSize: value.defaultTitleSize,
                            color: ThemeColorsHelper.getTextColor()),
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                                width: 2.0,
                                color: ThemeColorsHelper.getTextColor()),
                            insets:
                                const EdgeInsets.symmetric(horizontal: 16.0)),
                        tabs: value.categories
                            .map((e) => Tab(text: e.name.toString()))
                            .toList(),
                      )),
                ),
                body: TabBarView(
                  controller: value.tabController,
                  children: List.generate(
                      value.categories.length,
                      (index) => RefreshIndicator(
                          child: value.cateId == value.categories[index].id
                              ? SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: 250,
                                          child: CarouselSlider(
                                            options: CarouselOptions(
                                              autoPlay: true,
                                              enlargeCenterPage: false,
                                              viewportFraction: 1.0,
                                              enlargeStrategy:
                                                  CenterPageEnlargeStrategy
                                                      .height,
                                            ),
                                            items: value.banners
                                                .map<Widget>((item) =>
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (item.type == 1) {
                                                          Get.find<
                                                                  HomeController>()
                                                              .openBannerRoutes(
                                                                  item);
                                                        } else if (item.type ==
                                                            2) {
                                                          Get.find<
                                                                  HomeController>()
                                                              .launchURL(
                                                                  item.value);
                                                        }
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 250,
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                          fit: BoxFit.fitHeight,
                                                          image: FadeInImage(
                                                            width:
                                                                double.infinity,
                                                            height: 250,
                                                            placeholder:
                                                                const AssetImage(
                                                                    'assets/images/placeholder.jpeg'),
                                                            image: NetworkImage(
                                                                '${Environments.apiBaseURL}storage/images/${item.cover}'),
                                                            imageErrorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image.asset(
                                                                  'assets/images/placeholder.jpeg',
                                                                  height: 30,
                                                                  width: 30,
                                                                  fit: BoxFit
                                                                      .fitWidth);
                                                            },
                                                          ).image,
                                                        )),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Container(
                                                            width: 300,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 40),
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            150,
                                                                            0,
                                                                            0,
                                                                            0)),
                                                            child: Text(
                                                              item.text
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: ThemeProvider
                                                                      .whiteColor,
                                                                  fontSize: value
                                                                      .defaultTitleSize,
                                                                  fontFamily:
                                                                      'medium'),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 100,
                                        //   child: AdWidget(ad: value.myBanner),
                                        // ),
                                        value.news.isEmpty &&
                                                value.newsCalled == true
                                            ? Text(
                                                'No Data Found'.tr,
                                                style: TextStyle(
                                                    color: ThemeColorsHelper
                                                        .getTextColor()),
                                              )
                                            : Column(
                                                children: [
                                                  Column(
                                                    children: List.generate(
                                                        value.news.length,
                                                        (newsIndex) => InkWell(
                                                              onTap: () {
                                                                Get.find<HomeController>().navigateDetails(
                                                                    int.parse(value
                                                                        .news[
                                                                            newsIndex]
                                                                        .id
                                                                        .toString()),
                                                                    value
                                                                        .news[
                                                                            newsIndex]
                                                                        .urlSlugs
                                                                        .toString());
                                                              },
                                                              child: Wrap(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            230,
                                                                        child:
                                                                            Wrap(
                                                                          children: [
                                                                            RichText(
                                                                              text: TextSpan(
                                                                                text: '${value.news[newsIndex].title} : ',
                                                                                style: TextStyle(color: fromHex(value.news[newsIndex].titleColor.toString()), fontFamily: 'bold', fontSize: value.defaultTitleSize),
                                                                                children: <TextSpan>[
                                                                                  TextSpan(
                                                                                    text: value.news[newsIndex].shortDescriptions.toString(),
                                                                                    style: TextStyle(color: ThemeColorsHelper.getTextColor(), fontFamily: 'bold', fontSize: value.defaultDescriptionSize),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              80,
                                                                          width:
                                                                              80,
                                                                          child: value.news[newsIndex].videoUrl != 'NA'
                                                                              ? Stack(
                                                                                  children: <Widget>[
                                                                                    FadeInImage(
                                                                                      height: 80,
                                                                                      width: 80,
                                                                                      image: NetworkImage('${Environments.apiBaseURL}storage/images/${value.news[newsIndex].cover}'),
                                                                                      placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                                                                      imageErrorBuilder: (context, error, stackTrace) {
                                                                                        return Image.asset('assets/images/placeholder.jpeg', height: 80, width: 80, fit: BoxFit.fitWidth);
                                                                                      },
                                                                                      fit: BoxFit.fitWidth,
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: Image.asset(
                                                                                        'assets/images/play-button.png',
                                                                                        height: 20,
                                                                                        width: 20,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              : FadeInImage(
                                                                                  height: 80,
                                                                                  width: 80,
                                                                                  image: NetworkImage('${Environments.apiBaseURL}storage/images/${value.news[newsIndex].cover}'),
                                                                                  placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                                                                  imageErrorBuilder: (context, error, stackTrace) {
                                                                                    return Image.asset('assets/images/placeholder.jpeg', height: 80, width: 80, fit: BoxFit.fitWidth);
                                                                                  },
                                                                                  fit: BoxFit.fitWidth,
                                                                                ))
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          value
                                                                              .news[newsIndex]
                                                                              .cateName
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontFamily: 'semibold',
                                                                              fontSize: value.defaultTitleSize,
                                                                              color: ThemeColorsHelper.getGrayColor()),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          value
                                                                              .news[newsIndex]
                                                                              .cityName
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontFamily: 'semibold',
                                                                              fontSize: value.defaultTitleSize,
                                                                              color: ThemeColorsHelper.getGrayColor()),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          '${'By '.tr}${value.news[newsIndex].authorFirstName} ${value.news[newsIndex].authorLastName}',
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontFamily: 'semibold',
                                                                              fontSize: value.defaultTitleSize,
                                                                              color: ThemeColorsHelper.getGrayColor()),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 40,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        bottom: BorderSide(
                                                                            color:
                                                                                ThemeColorsHelper.getGrayColor()),
                                                                        top: BorderSide(
                                                                            color:
                                                                                ThemeColorsHelper.getGrayColor()),
                                                                      ),
                                                                    ),
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            5),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Get.find<HomeController>().saveLikes(value.news[newsIndex]);
                                                                            },
                                                                            child: RichText(
                                                                                textAlign: TextAlign.center,
                                                                                text: TextSpan(children: [
                                                                                  WidgetSpan(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(right: 5),
                                                                                      child: Icon(value.news[newsIndex].haveLiked == true ? Icons.favorite : Icons.favorite_border, color: value.news[newsIndex].haveLiked == true ? ThemeProvider.appColor : ThemeColorsHelper.getGrayColor(), size: value.defaultTitleSize),
                                                                                    ),
                                                                                  ),
                                                                                  TextSpan(text: 'Like'.tr, style: TextStyle(color: value.news[newsIndex].haveLiked == true ? ThemeProvider.appColor : ThemeColorsHelper.getGrayColor(), fontSize: value.defaultTitleSize)),
                                                                                ])),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Get.find<HomeController>().openComments(value.news[newsIndex]);
                                                                            },
                                                                            child: RichText(
                                                                                textAlign: TextAlign.center,
                                                                                text: TextSpan(children: [
                                                                                  WidgetSpan(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(right: 5),
                                                                                      child: Icon(Icons.comment_outlined, color: ThemeColorsHelper.getGrayColor(), size: value.defaultTitleSize),
                                                                                    ),
                                                                                  ),
                                                                                  TextSpan(text: 'Comments'.tr, style: TextStyle(color: ThemeColorsHelper.getGrayColor(), fontSize: value.defaultTitleSize)),
                                                                                ])),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Get.find<HomeController>().saveNews(value.news[newsIndex]);
                                                                            },
                                                                            child: RichText(
                                                                                textAlign: TextAlign.center,
                                                                                text: TextSpan(children: [
                                                                                  WidgetSpan(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(right: 5),
                                                                                      child: Icon(Icons.save_alt_outlined, color: value.news[newsIndex].haveSaved == true ? ThemeProvider.appColor : ThemeColorsHelper.getGrayColor(), size: value.defaultTitleSize),
                                                                                    ),
                                                                                  ),
                                                                                  TextSpan(text: 'Save'.tr, style: TextStyle(color: value.news[newsIndex].haveSaved == true ? ThemeProvider.appColor : ThemeColorsHelper.getGrayColor(), fontSize: value.defaultTitleSize)),
                                                                                ])),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Get.find<HomeController>().share(value.news[newsIndex]);
                                                                            },
                                                                            child: RichText(
                                                                                textAlign: TextAlign.center,
                                                                                text: TextSpan(children: [
                                                                                  WidgetSpan(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(right: 5),
                                                                                      child: Icon(Icons.share_outlined, color: ThemeColorsHelper.getGrayColor(), size: value.defaultTitleSize),
                                                                                    ),
                                                                                  ),
                                                                                  TextSpan(text: 'Share'.tr, style: TextStyle(color: ThemeColorsHelper.getGrayColor(), fontSize: value.defaultTitleSize)),
                                                                                ])),
                                                                          )
                                                                        ]),
                                                                  )
                                                                ],
                                                              ),
                                                            )),
                                                  ),
                                                  value.loadMore == true
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: ThemeProvider
                                                                .appColor,
                                                          ),
                                                        )
                                                      : const SizedBox()
                                                ],
                                              )
                                      ],
                                    ),
                                  ),
                                )
                              : buildDummy(),
                          onRefresh: () async {
                            await value.hardRefresh();
                          })),
                ),
                bottomNavigationBar: Container(
                  height: value.myBanner.size.height.toDouble(),
                  color: Colors.transparent,
                  child: AdWidget(ad: value.myBanner),
                ),
                // bottomNavigationBar: AdWidget(ad: myBanner),
              ),
            )
          : buildDummy();
    });
  }

  Widget buildDummy() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration:
              BoxDecoration(color: ThemeColorsHelper.getBackgroundColor()),
          child: SkeletonItem(
              child: Column(
            children: [
              Row(
                children: [
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        shape: BoxShape.circle, width: 50, height: 50),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 3,
                          spacing: 6,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 10,
                            borderRadius: BorderRadius.circular(8),
                            minLength: MediaQuery.of(context).size.width / 6,
                            maxLength: MediaQuery.of(context).size.width / 3,
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 3,
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 2,
                    )),
              ),
              const SizedBox(height: 12),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  minHeight: MediaQuery.of(context).size.height / 8,
                  maxHeight: MediaQuery.of(context).size.height / 3,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 20, height: 20)),
                      SizedBox(width: 8),
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 20, height: 20)),
                      SizedBox(width: 8),
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 20, height: 20)),
                    ],
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 16,
                        width: 64,
                        borderRadius: BorderRadius.circular(8)),
                  )
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
