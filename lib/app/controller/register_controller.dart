import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/parse/register_parse.dart';
import 'package:ultimate_news/app/controller/home_controller.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/util/toast.dart';

class RegisterController extends GetxController implements GetxService {
  final RegisterParser parser;

  final firstNameRegister = TextEditingController();
  final lastNameRegister = TextEditingController();
  final emailRegister = TextEditingController();
  final passwordRegister = TextEditingController();
  final mobileRegister = TextEditingController();
  String countryCode = '+91';
  RxBool passwordVisible = false.obs;
  RxBool isLogin = false.obs;
  RegisterController({required this.parser});

  Future<void> register() async {
    if (firstNameRegister.text == '' ||
        emailRegister.text == '' ||
        passwordRegister.text == '' ||
        mobileRegister.text == '' ||
        lastNameRegister.text == '') {
      showToast('All fields are required');
      return;
    }
    if (!GetUtils.isEmail(emailRegister.text)) {
      showToast('Email is not valid');
      return;
    }
    isLogin.value = !isLogin.value;
    update();
    var param = {
      'email': emailRegister.text,
      'first_name': firstNameRegister.text,
      'last_name': lastNameRegister.text,
      'mobile': mobileRegister.text,
      'country_code': countryCode,
      'password': passwordRegister.text,
      'cover': 'NA'
    };
    Response response = await parser.registerPost(param);
    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['user'] != '' && myMap['authorisation'] != '') {
        parser.saveInfo(
            myMap['authorisation']['token'].toString(),
            myMap['user']['id'].toString(),
            firstNameRegister.text,
            lastNameRegister.text);
        Get.delete<HomeController>(force: true);
        Get.toNamed(AppRouter.getTabsRoutes());
      } else {
        showToast('Something went wrong while signup');
      }
      update();
    } else if (response.statusCode == 500) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['success'] == false) {
        showToast(myMap['message']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else {
      isLogin.value = !isLogin.value;
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  void updateCountryCode(String code) {
    countryCode = code;
    update();
  }

  void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
    update();
  }
}
