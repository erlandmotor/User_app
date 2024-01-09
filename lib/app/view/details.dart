import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/details_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/theme.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void dispose() {
    super.dispose();
    Get.find<DetailsController>().stop();
  }

  @override
  Widget build(BuildContext context) {
    Color fromHex(String hexString) {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }

    return GetBuilder<DetailsController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: ThemeColorsHelper.getBackgroundColor(),
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: ThemeColorsHelper.getTextColor(),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  value.saveLikesCurrent();
                },
                icon: value.haveLiked == true
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                color: value.haveLiked == true
                    ? ThemeProvider.appColor
                    : ThemeColorsHelper.getTextColor(),
              ),
              IconButton(
                onPressed: () {
                  value.openCommentsCurrent();
                },
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: ThemeColorsHelper.getTextColor(),
                ),
              ),
              IconButton(
                onPressed: () {
                  value.saveNewsCurrent();
                },
                icon: const Icon(Icons.save_alt_outlined),
                color: value.haveSaved == true
                    ? ThemeProvider.appColor
                    : ThemeColorsHelper.getTextColor(),
              ),
              IconButton(
                onPressed: () {
                  value.shareCurrent();
                },
                icon: Icon(
                  Icons.share_outlined,
                  color: ThemeColorsHelper.getTextColor(),
                ),
              ),
            ],
          ),
        ),
        body: value.categoriesCalled == false
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '${value.news.title} : ',
                              style: TextStyle(
                                  color:
                                      fromHex(value.news.titleColor.toString()),
                                  fontFamily: 'bold',
                                  fontSize: value.defaultTitleSize),
                              children: <TextSpan>[
                                TextSpan(
                                  text: value.news.shortDescriptions.toString(),
                                  style: TextStyle(
                                      color: ThemeColorsHelper.getTextColor(),
                                      fontFamily: 'bold',
                                      fontSize: value.defaultDescriptionSize),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  value.news.cateName.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'semibold',
                                      fontSize: value.defaultTitleSize,
                                      color: ThemeColorsHelper.getTextColor()),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${'By '.tr}${value.news.authorFirstName} ${value.news.authorLastName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'semibold',
                                      fontSize: value.defaultTitleSize,
                                      color: ThemeColorsHelper.getTextColor()),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  value.news.createdAt.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'semibold',
                                      fontSize: value.defaultTitleSize,
                                      color: ThemeColorsHelper.getTextColor()),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 300,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: value.news.videoUrl != 'NA'
                                ? InkWell(
                                    onTap: () {
                                      value.openSingleVideoScreen();
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        FadeInImage(
                                          height: 300,
                                          width: double.infinity,
                                          image: NetworkImage(
                                              '${Environments.apiBaseURL}storage/images/${value.news.cover}'),
                                          placeholder: const AssetImage(
                                              "assets/images/placeholder.jpeg"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/images/placeholder.jpeg',
                                                height: 300,
                                                width: double.infinity,
                                                fit: BoxFit.fitWidth);
                                          },
                                          fit: BoxFit.fitWidth,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            'assets/images/play-button.png',
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : FadeInImage(
                                    height: 300,
                                    width: double.infinity,
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.news.cover}'),
                                    placeholder: const AssetImage(
                                        "assets/images/placeholder.jpeg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/placeholder.jpeg',
                                          height: 300,
                                          width: double.infinity,
                                          fit: BoxFit.fitWidth);
                                    },
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Listen News'.tr,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'bold',
                                      color: ThemeColorsHelper.getTextColor()),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          value.speak();
                                        },
                                        icon: Icon(
                                          Icons.play_arrow,
                                          color:
                                              ThemeColorsHelper.getTextColor(),
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          value.pause();
                                        },
                                        icon: Icon(Icons.stop,
                                            color: ThemeColorsHelper
                                                .getTextColor())),
                                    IconButton(
                                        onPressed: () {
                                          value.stop();
                                        },
                                        icon: Icon(Icons.pause,
                                            color: ThemeColorsHelper
                                                .getTextColor())),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Wrap(
                            children: [
                              Html(
                                data: value.news.content.toString(),
                                style: {
                                  "p": Style(
                                      color: ThemeColorsHelper.getTextColor(),
                                      fontSize:
                                          FontSize(value.defaultContentSize))
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Text(
                              'See Another News..'.tr,
                              style: TextStyle(
                                  fontSize: value.defaultContentSize,
                                  color: ThemeColorsHelper.getTextColor()),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: ThemeColorsHelper.getGrayColor(),
                              border: Border(
                                bottom: BorderSide(
                                    color: ThemeColorsHelper.getGrayColor()),
                                top: BorderSide(
                                    color: ThemeColorsHelper.getGrayColor()),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Column(
                        children: List.generate(
                            value.related.length,
                            (newsIndex) => InkWell(
                                  onTap: () {
                                    Get.delete<DetailsController>(force: true);

                                    Get.toNamed(AppRouter.getDetailsRoutes(),
                                        arguments: [
                                          value.related[newsIndex].id
                                              .toString(),
                                          value.related[newsIndex].urlSlugs
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
                                                        '${value.related[newsIndex].title} : ',
                                                    style: TextStyle(
                                                        color: fromHex(value
                                                            .related[newsIndex]
                                                            .titleColor
                                                            .toString()),
                                                        fontFamily: 'bold',
                                                        fontSize: value
                                                            .defaultTitleSize),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: value
                                                            .related[newsIndex]
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
                                                    '${Environments.apiBaseURL}storage/images/${value.related[newsIndex].cover}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/placeholder.jpeg"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
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
                                              value.related[newsIndex].cateName
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
                                              value.related[newsIndex].cityName
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
                                              '${'By '.tr}${value.related[newsIndex].authorFirstName} ${value.related[newsIndex].authorLastName}',
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
                                                  Get.find<DetailsController>()
                                                      .saveLikes(value
                                                          .related[newsIndex]);
                                                },
                                                child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      WidgetSpan(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5),
                                                          child: Icon(
                                                            value.related[newsIndex]
                                                                        .haveLiked ==
                                                                    true
                                                                ? Icons.favorite
                                                                : Icons.favorite_border,
                                                            color: value
                                                                        .related[
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
                                                                          .related[
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
                                                  Get.find<DetailsController>()
                                                      .openComments(value
                                                          .related[newsIndex]);
                                                },
                                                child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      WidgetSpan(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5),
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
                                                              fontSize: value
                                                                  .defaultTitleSize,
                                                              color: ThemeColorsHelper
                                                                  .getGrayColor())),
                                                    ])),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.find<DetailsController>()
                                                      .saveNews(value
                                                          .related[newsIndex]);
                                                },
                                                child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      WidgetSpan(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5),
                                                          child: Icon(
                                                            Icons
                                                                .save_alt_outlined,
                                                            color: value
                                                                        .related[
                                                                            newsIndex]
                                                                        .haveSaved ==
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
                                                          text: 'Save'.tr,
                                                          style: TextStyle(
                                                              fontSize: value
                                                                  .defaultTitleSize,
                                                              color: value
                                                                          .related[
                                                                              newsIndex]
                                                                          .haveSaved ==
                                                                      true
                                                                  ? ThemeProvider
                                                                      .appColor
                                                                  : ThemeColorsHelper
                                                                      .getGrayColor())),
                                                    ])),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.find<DetailsController>()
                                                      .share(value
                                                          .related[newsIndex]);
                                                },
                                                child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      WidgetSpan(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5),
                                                          child: Icon(
                                                            Icons
                                                                .share_outlined,
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
                                                              fontSize: value
                                                                  .defaultTitleSize,
                                                              color: ThemeColorsHelper
                                                                  .getGrayColor())),
                                                    ])),
                                              )
                                            ]),
                                      )
                                    ],
                                  ),
                                )),
                      )
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
