import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:ultimate_news/app/controller/saved_news_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/theme.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({super.key});

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  @override
  Widget build(BuildContext context) {
    Color fromHex(String hexString) {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }

    return GetBuilder<SavedNewsController>(builder: (value) {
      return Scaffold(
          backgroundColor: ThemeColorsHelper.getBackgroundColor(),
          appBar: AppBar(
            backgroundColor: ThemeColorsHelper.getBackgroundColor(),
            elevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Text(
              'Saved News'.tr,
              style: TextStyle(color: ThemeColorsHelper.getTextColor()),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: ThemeColorsHelper.getTextColor(),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: value.apiCalled == true
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: List.generate(
                          value.news.length,
                          (newsIndex) => InkWell(
                                onTap: () {
                                  Get.delete<SavedNewsController>(force: true);

                                  Get.toNamed(AppRouter.getDetailsRoutes(),
                                      arguments: [
                                        value.news[newsIndex].id.toString(),
                                        value.news[newsIndex].urlSlugs
                                            .toString()
                                      ],
                                      preventDuplicates: false);
                                },
                                child: Wrap(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 230,
                                          child: Wrap(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                      '${value.news[newsIndex].title} : ',
                                                  style: TextStyle(
                                                      color: fromHex(value
                                                          .news[newsIndex]
                                                          .titleColor
                                                          .toString()),
                                                      fontFamily: 'bold',
                                                      fontSize: value
                                                          .defaultTitleSize),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: value
                                                          .news[newsIndex]
                                                          .shortDescriptions
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: ThemeColorsHelper
                                                              .getTextColor(),
                                                          fontFamily: 'bold',
                                                          fontSize: value
                                                              .defaultDescriptionSize),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: FadeInImage(
                                              height: 80,
                                              width: 80,
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${value.news[newsIndex].cover}'),
                                              placeholder: const AssetImage(
                                                  "assets/images/placeholder.jpeg"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    'assets/images/placeholder.jpeg',
                                                    height: 80,
                                                    width: 80,
                                                    fit: BoxFit.fitWidth);
                                              },
                                              fit: BoxFit.fitWidth,
                                            ))
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            value.news[newsIndex].cateName
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'semibold',
                                                fontSize:
                                                    value.defaultTitleSize,
                                                color: ThemeColorsHelper
                                                    .getGrayColor()),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            value.news[newsIndex].cityName
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'semibold',
                                                fontSize:
                                                    value.defaultTitleSize,
                                                color: ThemeColorsHelper
                                                    .getGrayColor()),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${'By '.tr}${value.news[newsIndex].authorFirstName} ${value.news[newsIndex].authorLastName}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'semibold',
                                                fontSize:
                                                    value.defaultTitleSize,
                                                color: ThemeColorsHelper
                                                    .getGrayColor()),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: ThemeColorsHelper
                                                  .getGrayColor()),
                                          top: BorderSide(
                                              color: ThemeColorsHelper
                                                  .getGrayColor()),
                                        ),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.find<SavedNewsController>()
                                                    .saveLikes(
                                                        value.news[newsIndex]);
                                              },
                                              child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(children: [
                                                    WidgetSpan(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Icon(
                                                          value.news[newsIndex]
                                                                      .haveLiked ==
                                                                  true
                                                              ? Icons.favorite
                                                              : Icons
                                                                  .favorite_border,
                                                          color: value
                                                                      .news[
                                                                          newsIndex]
                                                                      .haveLiked ==
                                                                  true
                                                              ? ThemeProvider
                                                                  .appColor
                                                              : ThemeColorsHelper
                                                                  .getGrayColor(),
                                                          size: value
                                                              .defaultTitleSize,
                                                        ),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                        text: 'Like'.tr,
                                                        style: TextStyle(
                                                            fontSize: value
                                                                .defaultTitleSize,
                                                            color: value
                                                                        .news[
                                                                            newsIndex]
                                                                        .haveLiked ==
                                                                    true
                                                                ? ThemeProvider
                                                                    .appColor
                                                                : ThemeColorsHelper
                                                                    .getGrayColor())),
                                                  ])),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.find<SavedNewsController>()
                                                    .openComments(
                                                        value.news[newsIndex]);
                                              },
                                              child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(children: [
                                                    WidgetSpan(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Icon(
                                                          Icons
                                                              .comment_outlined,
                                                          color: ThemeColorsHelper
                                                              .getGrayColor(),
                                                          size: value
                                                              .defaultTitleSize,
                                                        ),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                        text: 'Comments'.tr,
                                                        style: TextStyle(
                                                            color: ThemeColorsHelper
                                                                .getGrayColor(),
                                                            fontSize: value
                                                                .defaultTitleSize)),
                                                  ])),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.find<SavedNewsController>()
                                                    .saveNews(
                                                        value.news[newsIndex]);
                                              },
                                              child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(children: [
                                                    WidgetSpan(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Icon(
                                                          Icons
                                                              .save_alt_outlined,
                                                          color: ThemeProvider
                                                              .appColor,
                                                          size: value
                                                              .defaultTitleSize,
                                                        ),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                        text: 'Save'.tr,
                                                        style: TextStyle(
                                                            color: ThemeProvider
                                                                .appColor,
                                                            fontSize: value
                                                                .defaultTitleSize)),
                                                  ])),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.find<SavedNewsController>()
                                                    .share(
                                                        value.news[newsIndex]);
                                              },
                                              child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(children: [
                                                    WidgetSpan(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Icon(
                                                          Icons.share_outlined,
                                                          color: ThemeColorsHelper
                                                              .getGrayColor(),
                                                          size: value
                                                              .defaultTitleSize,
                                                        ),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                        text: 'Share'.tr,
                                                        style: TextStyle(
                                                            color: ThemeColorsHelper
                                                                .getGrayColor(),
                                                            fontSize: value
                                                                .defaultTitleSize)),
                                                  ])),
                                            )
                                          ]),
                                    )
                                  ],
                                ),
                              )),
                    ),
                  ),
                )
              : buildDummy());
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
