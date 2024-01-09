import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/contact_controller.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/theme.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        appBar: AppBar(
          backgroundColor: ThemeColorsHelper.getBackgroundColor(),
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Contact Us'.tr,
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
                                controller: value.nameContact,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: ThemeProvider.blackColor,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: 'Full Name'.tr,
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: value.emailContanct,
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: value.messageContanct,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                style: const TextStyle(
                                    color: ThemeProvider.blackColor,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: 'Message'.tr,
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
                              horizontal: 0.0, vertical: 20.0),
                          child: InkWell(
                            onTap: () {
                              value.saveContacts();
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
                                          'Submit'.tr,
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
                    )
                  ],
                )),
          ),
        ),
      );
    });
  }
}
