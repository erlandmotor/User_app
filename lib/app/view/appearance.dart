import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/appearance_controller.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/theme.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  @override
  Widget build(BuildContext context) {
    Color fromHex(String hexString) {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }

    return GetBuilder<AppearanceController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        appBar: AppBar(
          backgroundColor: ThemeColorsHelper.getBackgroundColor(),
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Appearance'.tr,
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
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Title Size'.tr,
                      style: TextStyle(
                          fontFamily: 'bold',
                          fontSize: 14,
                          color: ThemeColorsHelper.getTextColor()),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              value.updateTitleSize('remove');
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: ThemeColorsHelper.getTextColor(),
                            )),
                        Text(
                          value.defaultTitleSize.toString(),
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 14,
                              color: ThemeColorsHelper.getTextColor()),
                        ),
                        IconButton(
                            onPressed: () {
                              value.updateTitleSize('add');
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: ThemeColorsHelper.getTextColor(),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Descriptions Size'.tr,
                      style: TextStyle(
                          fontFamily: 'bold',
                          fontSize: 14,
                          color: ThemeColorsHelper.getTextColor()),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              value.updateDescriptionSize('remove');
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: ThemeColorsHelper.getTextColor(),
                            )),
                        Text(
                          value.defaultDescriptionSize.toString(),
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 14,
                              color: ThemeColorsHelper.getTextColor()),
                        ),
                        IconButton(
                            onPressed: () {
                              value.updateDescriptionSize('add');
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: ThemeColorsHelper.getTextColor(),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Content Size'.tr,
                      style: TextStyle(
                          fontFamily: 'bold',
                          fontSize: 14,
                          color: ThemeColorsHelper.getTextColor()),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              value.updateContentSize('remove');
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: ThemeColorsHelper.getTextColor(),
                            )),
                        Text(
                          value.defaultContentSize.toString(),
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 14,
                              color: ThemeColorsHelper.getTextColor()),
                        ),
                        IconButton(
                            onPressed: () {
                              value.updateContentSize('add');
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: ThemeColorsHelper.getTextColor(),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ThemeColorsHelper.getGrayColor(),
                      width: 1.0,
                    ),
                    top: BorderSide(
                      color: ThemeColorsHelper.getGrayColor(),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Demo'.tr,
                      style: TextStyle(
                          fontFamily: 'bold',
                          fontSize: 19,
                          color: ThemeColorsHelper.getTextColor()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 230,
                              child: Wrap(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'News Title Dummy : '.tr,
                                      style: TextStyle(
                                          color: fromHex('#FF0000'),
                                          fontFamily: 'bold',
                                          fontSize: value.defaultTitleSize),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form '
                                                  .tr,
                                          style: TextStyle(
                                              color: ThemeColorsHelper
                                                  .getTextColor(),
                                              fontFamily: 'bold',
                                              fontSize:
                                                  value.defaultDescriptionSize),
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
                                  image: const AssetImage(
                                      'assets/images/placeholder.jpeg'),
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
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cate Name'.tr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'semibold',
                                    fontSize: value.defaultTitleSize,
                                    color: ThemeColorsHelper.getGrayColor()),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'City Name'.tr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'semibold',
                                    fontSize: value.defaultTitleSize,
                                    color: ThemeColorsHelper.getGrayColor()),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'By AuthorName'.tr,
                                overflow: TextOverflow.ellipsis,
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
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: ThemeColorsHelper.getGrayColor()),
                              top: BorderSide(
                                  color: ThemeColorsHelper.getGrayColor()),
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.favorite,
                                              color: ThemeProvider.appColor,
                                              size: value.defaultTitleSize,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                            text: 'Like'.tr,
                                            style: TextStyle(
                                                color: ThemeProvider.appColor,
                                                fontSize:
                                                    value.defaultTitleSize)),
                                      ])),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.comment_outlined,
                                              color: ThemeColorsHelper
                                                  .getGrayColor(),
                                              size: value.defaultTitleSize,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                            text: 'Comments'.tr,
                                            style: TextStyle(
                                                color: ThemeColorsHelper
                                                    .getGrayColor(),
                                                fontSize:
                                                    value.defaultTitleSize)),
                                      ])),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.save_alt_outlined,
                                              color: ThemeProvider.appColor,
                                              size: value.defaultTitleSize,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                            text: 'Save'.tr,
                                            style: TextStyle(
                                                color: ThemeProvider.appColor,
                                                fontSize:
                                                    value.defaultTitleSize)),
                                      ])),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.share_outlined,
                                              color: ThemeColorsHelper
                                                  .getGrayColor(),
                                              size: value.defaultTitleSize,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                            text: 'Share'.tr,
                                            style: TextStyle(
                                                color: ThemeColorsHelper
                                                    .getGrayColor(),
                                                fontSize:
                                                    value.defaultTitleSize)),
                                      ])),
                                )
                              ]),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                      .tr,
                  style: TextStyle(
                      fontFamily: 'regular',
                      fontSize: value.defaultContentSize,
                      color: ThemeColorsHelper.getTextColor()),
                ),
              )
            ],
          ),
        )),
      );
    });
  }
}
