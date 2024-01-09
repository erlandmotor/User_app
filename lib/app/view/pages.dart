import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:ultimate_news/app/controller/pages_controller.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key});

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagesController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        appBar: AppBar(
          backgroundColor: ThemeColorsHelper.getBackgroundColor(),
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            value.pageName.toString(),
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
        body: value.apiCalled == true
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      Html(
                        data: value.content.toString(),
                        style: {
                          "p": Style(color: ThemeColorsHelper.getTextColor())
                        },
                      )
                    ],
                  ),
                ),
              )
            : buildDummy(),
      );
    });
  }

  Widget buildDummy() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration:
              BoxDecoration(color: ThemeColorsHelper.getBackgroundColor()),
          child: SkeletonItem(
              child: Column(
            children: [
              Row(
                children: [
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        shape: BoxShape.circle, width: 50, height: 50),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 3,
                          spacing: 6,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 10,
                            borderRadius: BorderRadius.circular(8),
                            minLength: MediaQuery.of(context).size.width / 6,
                            maxLength: MediaQuery.of(context).size.width / 3,
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 3,
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 2,
                    )),
              ),
              const SizedBox(height: 12),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  minHeight: MediaQuery.of(context).size.height / 8,
                  maxHeight: MediaQuery.of(context).size.height / 3,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 20, height: 20)),
                      SizedBox(width: 8),
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 20, height: 20)),
                      SizedBox(width: 8),
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 20, height: 20)),
                    ],
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 16,
                        width: 64,
                        borderRadius: BorderRadius.circular(8)),
                  )
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
