import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/account_controller.dart';
import 'package:ultimate_news/app/controller/appearance_controller.dart';
import 'package:ultimate_news/app/controller/contact_controller.dart';
import 'package:ultimate_news/app/controller/pages_controller.dart';
import 'package:ultimate_news/app/controller/saved_news_controller.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        appBar: AppBar(
          backgroundColor: ThemeColorsHelper.getBackgroundColor(),
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Profile'.tr,
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
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    value.haveAccount == false
                        ? GestureDetector(
                            onTap: () {
                              Get.offNamed(AppRouter.getLoginRoutes());
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    color: ThemeColorsHelper.getTextColor(),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Sign In / Sign Up'.tr,
                                        style: TextStyle(
                                            color: ThemeColorsHelper
                                                .getTextColor()),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: ThemeColorsHelper.getTextColor(),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.supervised_user_circle_outlined,
                                  color: ThemeColorsHelper.getTextColor(),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      value.userName,
                                      style: TextStyle(
                                          color:
                                              ThemeColorsHelper.getTextColor()),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Settings'.tr,
                      style: TextStyle(
                          fontSize: 15,
                          color: ThemeColorsHelper.getTextColor(),
                          fontFamily: 'bold'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    value.haveAccount == true
                        ? GestureDetector(
                            onTap: () {
                              Get.delete<SavedNewsController>(force: true);
                              Get.toNamed(AppRouter.getSavedNewsRoutes());
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                children: [
                                  Icon(Icons.bookmark_add_outlined,
                                      color: ThemeColorsHelper.getTextColor()),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Saved News'.tr,
                                        style: TextStyle(
                                            color: ThemeColorsHelper
                                                .getTextColor()),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: ThemeColorsHelper.getTextColor(),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRouter.getLanguagesRoutes());
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.translate_outlined,
                              color: ThemeColorsHelper.getTextColor(),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Languages'.tr,
                                  style: TextStyle(
                                      color: ThemeColorsHelper.getTextColor()),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: ThemeColorsHelper.getTextColor(),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.delete<ContactController>(force: true);
                        Get.toNamed(AppRouter.getContactRoutues());
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.contact_mail_outlined,
                              color: ThemeColorsHelper.getTextColor(),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Contact Us'.tr,
                                  style: TextStyle(
                                      color: ThemeColorsHelper.getTextColor()),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: ThemeColorsHelper.getTextColor(),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.delete<AppearanceController>(force: true);
                        Get.toNamed(AppRouter.getAppearanceRoutes());
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.text_increase,
                              color: ThemeColorsHelper.getTextColor(),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'News Fonts Size'.tr,
                                  style: TextStyle(
                                      color: ThemeColorsHelper.getTextColor()),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: ThemeColorsHelper.getTextColor(),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.delete<PagesController>(force: true);
                        Get.toNamed(AppRouter.getPageRoutes(),
                            arguments: ['Privacy Policy'.tr, '2'],
                            preventDuplicates: false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.privacy_tip_outlined,
                              color: ThemeColorsHelper.getTextColor(),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Privacy Policy'.tr,
                                  style: TextStyle(
                                      color: ThemeColorsHelper.getTextColor()),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: ThemeColorsHelper.getTextColor(),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.delete<PagesController>(force: true);
                        Get.toNamed(AppRouter.getPageRoutes(),
                            arguments: ['About Us'.tr, '1'],
                            preventDuplicates: false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: ThemeColorsHelper.getTextColor(),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'About Us'.tr,
                                  style: TextStyle(
                                      color: ThemeColorsHelper.getTextColor()),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: ThemeColorsHelper.getTextColor(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: [
                          Icon(
                            value.isSwitched == false
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            color: ThemeColorsHelper.getTextColor(),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                value.isSwitched == false
                                    ? 'Light Mode'.tr
                                    : 'Dark Mode'.tr,
                                style: TextStyle(
                                    color: ThemeColorsHelper.getTextColor()),
                              ),
                            ),
                          ),
                          Switch(
                            onChanged: value.toggleSwitch,
                            value: value.isSwitched,
                            activeColor: Colors.black26,
                            activeTrackColor: Colors.grey,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    value.haveAccount == true
                        ? GestureDetector(
                            onTap: () {
                              value.logout();
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout_outlined,
                                    color: ThemeColorsHelper.getTextColor(),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Logout'.tr,
                                        style: TextStyle(
                                            color: ThemeColorsHelper
                                                .getTextColor()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
