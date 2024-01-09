import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/parse/reset_parse.dart';
import 'package:ultimate_news/app/util/toast.dart';

class ResetController extends GetxController implements GetxService {
  final ResetParser parser;

  final emailReset = TextEditingController();
  final passwordReset = TextEditingController();
  final passwordConfirmReset = TextEditingController();
  RxBool passwordVisible = false.obs;
  int tabId = 1;
  RxBool isLogin = false.obs;
  int otpId = 0;
  String userOTP = '';

  ResetController({required this.parser});

  void saveLanguage(String code) {
    parser.saveLanguage(code);
  }

  void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
    update();
  }

  Future<void> sendEmail() async {
    if (emailReset.text == '' || emailReset.text == '') {
      showToast('All fields are required');
      return;
    }

    if (!GetUtils.isEmail(emailReset.text)) {
      showToast('Email is not valid');
      return;
    }
    isLogin.value = !isLogin.value;
    update();

    var param = {'email': emailReset.text};
    Response response = await parser.sendResetEmail(param);

    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['otp_id'] != '' && myMap['data'] == true) {
        otpId = myMap['otp_id'];
        tabId = 2;
      } else {
        showToast('Something went wrong while signup');
      }
      update();
    } else if (response.statusCode == 404) {
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

  void savedOTP(otp) {
    userOTP = otp;
    update();
  }

  Future<void> verifyOTP() async {
    if (userOTP == '' || userOTP.length != 6) {
      showToast('All fields are required');
      return;
    }
    isLogin.value = !isLogin.value;
    update();

    var param = {'otp': userOTP, 'id': otpId};
    Response response = await parser.verifyOTP(param);
    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['success'] == true) {
        tabId = 3;
      } else {
        showToast('Something went wrong while signup');
      }
      update();
    } else if (response.statusCode == 404) {
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

  Future<void> updateNewPassword() async {
    if (passwordReset.text == '' || passwordConfirmReset.text == '') {
      showToast('All fields are required');
      return;
    }
    if (passwordReset.text != passwordConfirmReset.text) {
      showToast('password does not match');
      return;
    }
    isLogin.value = !isLogin.value;
    update();

    var param = {
      'email': emailReset.text,
      'id': otpId,
      'password': passwordReset.text
    };
    Response response = await parser.updatePassword(param);
    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['success'] == true) {
        onBack();
      } else {
        showToast('Something went wrong while signup');
      }
      update();
    } else if (response.statusCode == 404) {
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

  onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
