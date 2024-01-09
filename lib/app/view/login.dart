import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/login_controller.dart';
import 'package:ultimate_news/app/controller/register_controller.dart';
import 'package:ultimate_news/app/controller/reset_controller.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        body: AbsorbPointer(
          absorbing: value.isLogin.value == false ? false : true,
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: value.emailLogin,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    color: ThemeProvider.blackColor,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: 'Email Address'.tr,
                                  labelStyle: const TextStyle(fontSize: 14),
                                  fillColor: ThemeProvider.whiteColor,
                                  filled: true,
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.appColor),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeProvider.greyColor)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: value.passwordLogin,
                                textInputAction: TextInputAction.next,
                                obscureText: value.passwordVisible.value == true
                                    ? false
                                    : true,
                                style: const TextStyle(
                                    color: ThemeProvider.blackColor,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: 'Password'.tr,
                                  labelStyle: const TextStyle(fontSize: 14),
                                  filled: true,
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.appColor),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeProvider.greyColor)),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      value.togglePassword();
                                    },
                                    icon: Icon(
                                      value.passwordVisible.value == false
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: ThemeProvider.appColor,
                                    ),
                                  ),
                                  fillColor: ThemeProvider.whiteColor,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.delete<ResetController>(force: true);
                                Get.toNamed(
                                  AppRouter.getResetRoutes(),
                                );
                              },
                              child: Text(
                                'Forgot Password ?'.tr,
                                style: const TextStyle(
                                    color: ThemeProvider.appColor),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 20.0),
                          child: InkWell(
                            onTap: () {
                              value.login();
                            },
                            child: Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 13.0),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50.0),
                                  ),
                                  color: ThemeProvider.appColor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  value.isLogin.value == true
                                      ? const CircularProgressIndicator(
                                          color: ThemeProvider.whiteColor,
                                        )
                                      : Text(
                                          'Sign In'.tr,
                                          style: const TextStyle(
                                              color: ThemeProvider.whiteColor,
                                              fontSize: 17,
                                              fontFamily: 'bold'),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have account ?".tr,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            ThemeColorsHelper.getTextColor()),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.delete<RegisterController>(
                                          force: true);
                                      Get.toNamed(
                                        AppRouter.getRegisterRoutes(),
                                      );
                                    },
                                    child: Text(
                                      'Sign Up'.tr,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: ThemeProvider.appColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
