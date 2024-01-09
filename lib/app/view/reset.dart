import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/style.dart';
import 'package:ultimate_news/app/controller/reset_controller.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/theme.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ThemeColorsHelper.getTextColor(),
            ),
          ),
          backgroundColor: ThemeColorsHelper.getBackgroundColor(),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Center(
            child: value.tabId == 1
                ? AbsorbPointer(
                    absorbing: value.isLogin.value == false ? false : true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            'Forgot Password'.tr,
                            style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 20,
                                color: ThemeColorsHelper.getTextColor()),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            'Please enter Email so we can help to recover your password.'
                                .tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: ThemeColorsHelper.getGrayColor()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: value.emailReset,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    color: ThemeProvider.blackColor,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: 'Email Address'.tr,
                                  fillColor: ThemeProvider.whiteColor,
                                  filled: true,
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.secondaryAppColor),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20.0),
                          child: InkWell(
                            onTap: () {
                              value.sendEmail();
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
                                          'Send OTP'.tr,
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
                      ],
                    ),
                  )
                : value.tabId == 2
                    ? AbsorbPointer(
                        absorbing: value.isLogin.value == false ? false : true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Text(
                                'Verification'.tr,
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 20,
                                    color: ThemeColorsHelper.getTextColor()),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Text(
                                'Enter the OTP code from the email we just send you.'
                                    .tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: ThemeColorsHelper.getGrayColor()),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    color: ThemeProvider.whiteColor,
                                    child: OTPTextField(
                                      length: 6,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5),
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      fieldWidth: 20,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: ThemeProvider.blackColor,
                                      ),
                                      textFieldAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      fieldStyle: FieldStyle.underline,
                                      onCompleted: (pin) {
                                        value.savedOTP(pin);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 20.0),
                              child: InkWell(
                                onTap: () {
                                  value.verifyOTP();
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 13.0),
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50.0),
                                      ),
                                      color: ThemeProvider.appColor),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Continue'.tr,
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
                          ],
                        ),
                      )
                    : value.tabId == 3
                        ? AbsorbPointer(
                            absorbing:
                                value.isLogin.value == false ? false : true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Text(
                                    'Reset Password'.tr,
                                    style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 20,
                                        color:
                                            ThemeColorsHelper.getTextColor()),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Text(
                                    'Enter your new password and confirm it.'
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            ThemeColorsHelper.getGrayColor()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: value.passwordReset,
                                        textInputAction: TextInputAction.next,
                                        obscureText:
                                            value.passwordVisible.value == true
                                                ? false
                                                : true,
                                        style: const TextStyle(
                                            color: ThemeProvider.blackColor,
                                            fontSize: 14),
                                        decoration: InputDecoration(
                                          labelText: 'Password'.tr,
                                          filled: true,
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ThemeProvider
                                                    .secondaryAppColor),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ThemeProvider
                                                          .greyColor)),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              value.togglePassword();
                                            },
                                            icon: Icon(
                                              value.passwordVisible.value ==
                                                      false
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: ThemeProvider.appColor,
                                            ),
                                          ),
                                          fillColor: ThemeProvider.whiteColor,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: value.passwordConfirmReset,
                                        textInputAction: TextInputAction.next,
                                        obscureText:
                                            value.passwordVisible.value == true
                                                ? false
                                                : true,
                                        style: const TextStyle(
                                            color: ThemeProvider.blackColor,
                                            fontSize: 14),
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password'.tr,
                                          filled: true,
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ThemeProvider
                                                    .secondaryAppColor),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ThemeProvider
                                                          .greyColor)),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              value.togglePassword();
                                            },
                                            icon: Icon(
                                              value.passwordVisible.value ==
                                                      false
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: ThemeProvider.appColor,
                                            ),
                                          ),
                                          fillColor: ThemeProvider.whiteColor,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20.0),
                                  child: InkWell(
                                    onTap: () {
                                      value.updateNewPassword();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13.0),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50.0),
                                          ),
                                          color: ThemeProvider.appColor),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Reset Password'.tr,
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
                              ],
                            ),
                          )
                        : const SizedBox(),
          ),
        ),
      );
    });
  }
}
