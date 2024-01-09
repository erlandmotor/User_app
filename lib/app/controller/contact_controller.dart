import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/parse/contact_parse.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/util/toast.dart';

class ContactController extends GetxController implements GetxService {
  final ContactParser parser;
  final nameContact = TextEditingController();
  final emailContanct = TextEditingController();
  final messageContanct = TextEditingController();

  RxBool isLogin = false.obs;
  ContactController({required this.parser});

  Future<void> saveContacts() async {
    if (emailContanct.text == '' ||
        nameContact.text == '' ||
        messageContanct.text == '') {
      showToast('All fields are required');
      return;
    }
    if (!GetUtils.isEmail(emailContanct.text)) {
      showToast('Email is not valid');
      return;
    }
    isLogin.value = !isLogin.value;
    update();
    DateTime now = DateTime.now();
    String date = now.toIso8601String().split('T').first;
    var param = {
      'name': nameContact.text,
      'email': emailContanct.text,
      'message': messageContanct.text,
      'status': '0',
      'date': date.toString()
    };

    Response response = await parser.saveContact(param);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body['id'] != '' && body['id'] != '') {
        sendToAdmin(body['id']);
      }
    } else {
      isLogin.value = !isLogin.value;
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> sendToAdmin(var id) async {
    var param = {
      'id': id,
      'subject': 'New Mail Request Received'.tr,
      'thank_you_text': 'You have received new mail'.tr,
      'header_text': 'New Contact Details'.tr,
      'email': Environments.contactEmail,
      'from_mail': emailContanct.text,
      'from_username': nameContact.text,
      'from_message': messageContanct.text,
      'to_respond':
          'We have received your request, we will respond on your issue soon'.tr
    };
    Response response = await parser.sendToMail(param);
    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      successToast('Contact Information Sent');
      nameContact.text = '';
      emailContanct.text = '';
      messageContanct.text = '';
      onBack();
    } else {
      isLogin.value = !isLogin.value;
      ApiChecker.checkApi(response);
      update();
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
