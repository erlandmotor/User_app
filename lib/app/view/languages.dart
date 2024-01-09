import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/languages_controller.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/constant.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguagesController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        appBar: AppBar(
          backgroundColor: ThemeColorsHelper.getBackgroundColor(),
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Languages'.tr,
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
          child: Column(children: [
            for (var language in AppConstants.languages)
              ListTile(
                title: Text(
                  language.languageName,
                  style: TextStyle(
                      color: ThemeColorsHelper.getTextColor(), fontSize: 14),
                ),
                leading: Radio(
                    activeColor: ThemeColorsHelper.getPrimary(),
                    value: language.languageCode,
                    groupValue: value.languageCode,
                    onChanged: (e) {
                      value.saveLanguages(e.toString());
                    }),
              )
          ]),
        ),
      );
    });
  }
}
