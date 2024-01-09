import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/helper/init.dart';
import 'package:ultimate_news/app/controller/theme_mode_controller.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/util/constant.dart';
import 'package:ultimate_news/app/util/theme.dart';
import 'package:ultimate_news/app/util/translator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,name:'initnews-4a2d7');
  await MainBinding().dependencies();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModeController>(builder: (themeValue) {
      return GetMaterialApp(
        title: AppConstants.appName,
        color: ThemeProvider.appColor,
        debugShowCheckedModeBanner: false,
        theme: themeValue.darkTheme ? dark : light,
        navigatorKey: Get.key,
        initialRoute: AppRouter.splashRoutes,
        getPages: AppRouter.routes,
        defaultTransition: Transition.native,
        translations: LocaleString(),
        locale: const Locale('en', 'US'),
      );
    });
  }
}
