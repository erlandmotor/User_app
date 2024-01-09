import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/parse/login_parse.dart';
import 'package:ultimate_news/app/controller/home_controller.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/util/toast.dart';

class LoginController extends GetxController implements GetxService {
  final LoginParser parser;
  final emailLogin = TextEditingController();
  final passwordLogin = TextEditingController();
  RxBool passwordVisible = false.obs;
  RxBool isLogin = false.obs;
  LoginController({required this.parser});

  void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
    update();
  }

  Future<void> login() async {
    if (emailLogin.text == '' || emailLogin.text.isEmpty) {
      showToast('Email address is required');
      return;
    }
    if (passwordLogin.text == '' || passwordLogin.text.isEmpty) {
      showToast('Password is required');
      return;
    }

    if (!GetUtils.isEmail(emailLogin.text)) {
      showToast('Email is not valid');
      return;
    }
    isLogin.value = !isLogin.value;
    update();

    var param = {'email': emailLogin.text, 'password': passwordLogin.text};
    Response response = await parser.loginPost(param);
    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['user'] != '' && myMap['token'] != '') {
        parser.saveInfo(
            myMap['token'].toString(),
            myMap['user']['id'].toString(),
            myMap['user']['first_name'].toString(),
            myMap['user']['last_name'].toString());
        Get.delete<HomeController>(force: true);
        Get.delete<LoginController>(force: true);
        Get.toNamed(AppRouter.getTabsRoutes());
      } else {
        showToast('Something went wrong while signup');
      }
      update();
    } else if (response.statusCode == 401) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['message'] != '') {
        showToast(myMap['message']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else if (response.statusCode == 500) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
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
}
