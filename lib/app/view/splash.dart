import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/splash_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/util/theme.dart';
import 'package:ultimate_news/app/util/toast.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    Get.find<SplashController>().initSharedData();
    _routing();
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  void _routing() {
    Timer(const Duration(seconds: 1), () async {
      Timer(const Duration(seconds: 1), () async {
        // Get.find<SplashController>().setIntro(true);
        debugPrint('default ${Get.find<SplashController>().getLanguageCode()}');
        if (Get.find<SplashController>().getLanguageCode() != '') {
          var locale = Get.find<SplashController>().getLanguageCode();
          Get.updateLocale(Locale(locale));
        } else {
          var locale =
              Get.find<SplashController>().defaultLanguage.languageCode != ''
                  ? Locale(Get.find<SplashController>()
                      .defaultLanguage
                      .languageCode
                      .toString())
                  : const Locale('en');
          Get.updateLocale(locale);
        }

        if (Get.find<SplashController>().showIntro() == false) {
          Get.find<SplashController>().setIntro(true);
          Get.offNamed(AppRouter.getIntroRoutes());
        } else {
          Get.find<SplashController>().setIntro(true);
          Get.offNamed(AppRouter.getTabsRoutes());
        }
      });
    });
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('error$e');
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    debugPrint(result.toString());
    bool isNotConnected = result != ConnectivityResult.wifi &&
        result != ConnectivityResult.mobile;

    if (isNotConnected) {
      showToast('No Internet Connection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (value) {
      return Scaffold(
        key: _globalKey,
        body: Stack(alignment: AlignmentDirectional.center, children: [
          const Image(
            image: AssetImage('assets/images/splash.jpg'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          const Positioned(
            top: 180,
            child: Center(
              child: Text(
                Environments.appName,
                style: TextStyle(
                    color: ThemeProvider.whiteColor, fontFamily: 'bold'),
              ),
            ), //CircularAvatar
          ),
          const Positioned(
            bottom: 50,
            child: Center(
              child: CircularProgressIndicator(
                color: ThemeProvider.whiteColor,
              ),
            ), //CircularAvatar
          ),
          Positioned(
            bottom: 20,
            child: Center(
              child: Text(
                'Developed By '.tr + Environments.companyName,
                style: const TextStyle(
                    color: ThemeProvider.whiteColor, fontFamily: 'bold'),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
