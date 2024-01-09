import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:ultimate_news/app/controller/comments_controller.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/theme.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentsController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColorsHelper.getBackgroundColor(),
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Comments'.tr,
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
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        resizeToAvoidBottomInset: false,
        body: value.commentsCalled == true
            ? ListView(
                controller: ScrollController(),
                children: List.generate(
                    value.comments.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: ThemeProvider.blackColor,
                                        width: 1.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            '${value.comments[index].firstName} ${value.comments[index].lastName}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: ThemeColorsHelper
                                                    .getPrimary()),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            value.comments[index].comments
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: ThemeColorsHelper
                                                    .getTextColor()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: ThemeColorsHelper.getBackgroundColor()),
                    child: SkeletonItem(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            const SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                  shape: BoxShape.circle,
                                  width: 50,
                                  height: 50),
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
                                      minLength:
                                          MediaQuery.of(context).size.width / 6,
                                      maxLength:
                                          MediaQuery.of(context).size.width / 3,
                                    )),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    )),
                  ),
                ),
              ),
        bottomNavigationBar: value.commentsCalled == true
            ? SingleChildScrollView(
                reverse: true,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: ThemeProvider.appColor.withOpacity(0.1),
                  ),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: Icon(
                            Icons.emoji_emotions_outlined,
                            color: ThemeColorsHelper.getTextColor(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          controller: value.commentsEditor,
                          style: const TextStyle(
                              color: ThemeProvider.blackColor, fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write a message...'.tr),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          value.saveComments();
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                              color: ThemeProvider.appColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              )),
                          child: const Icon(
                            Icons.near_me,
                            color: ThemeProvider.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      );
    });
  }
}
