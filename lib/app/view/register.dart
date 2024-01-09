import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/register_controller.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColorsHelper.getBackgroundColor(),
          elevation: 0,
        ),
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        body: AbsorbPointer(
          absorbing: value.isLogin.value == false ? false : true,
          child: SingleChildScrollView(
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
                              controller: value.firstNameRegister,
                              textInputAction: TextInputAction.next,
                              enabled:
                                  value.isLogin.value == true ? false : true,
                              textCapitalization: TextCapitalization.sentences,
                              style: const TextStyle(
                                  color: ThemeProvider.blackColor,
                                  fontSize: 14),
                              decoration: InputDecoration(
                                labelText: 'First Name'.tr,
                                labelStyle: const TextStyle(fontSize: 14),
                                filled: true,
                                fillColor: ThemeProvider.whiteColor,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
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
                              controller: value.lastNameRegister,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  color: ThemeProvider.blackColor,
                                  fontSize: 14),
                              decoration: InputDecoration(
                                labelText: 'Last Name'.tr,
                                labelStyle: const TextStyle(fontSize: 14),
                                fillColor: ThemeProvider.whiteColor,
                                filled: true,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.greyColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: CountryCodePicker(
                                backgroundColor:
                                    ThemeColorsHelper.getBackgroundColor(),
                                dialogBackgroundColor:
                                    ThemeColorsHelper.getBackgroundColor(),
                                textStyle: TextStyle(
                                    color: ThemeColorsHelper.getTextColor(),
                                    fontSize: 14),
                                searchStyle: TextStyle(
                                    color: ThemeColorsHelper.getTextColor(),
                                    fontSize: 14),
                                dialogTextStyle: TextStyle(
                                    color: ThemeColorsHelper.getTextColor(),
                                    fontSize: 14),
                                onChanged: (e) => value
                                    .updateCountryCode(e.dialCode.toString()),
                                initialSelection: 'IN',
                                favorite: const ['+91', 'IN'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                              )),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              controller: value.mobileRegister,
                              style: const TextStyle(
                                  color: ThemeProvider.blackColor,
                                  fontSize: 14),
                              decoration: InputDecoration(
                                labelText: 'Mobile Number'.tr,
                                labelStyle: const TextStyle(fontSize: 14),
                                filled: true,
                                fillColor: ThemeProvider.whiteColor,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.greyColor)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: value.emailRegister,
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
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
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
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: value.passwordRegister,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 20.0),
                        child: InkWell(
                          onTap: () {
                            value.register();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 13.0),
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
                                        'Sign Up'.tr,
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
                                  'You have already account ?'.tr,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: ThemeColorsHelper.getTextColor()),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'Log in'.tr,
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
      );
    });
  }
}
