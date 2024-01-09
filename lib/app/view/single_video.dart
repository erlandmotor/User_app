import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/single_video_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/video_player.dart';
import 'package:ultimate_news/app/util/theme.dart';

class SingleVideoScreen extends StatefulWidget {
  const SingleVideoScreen({super.key});

  @override
  State<SingleVideoScreen> createState() => _SingleVideoScreenState();
}

class _SingleVideoScreenState extends State<SingleVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleVideoController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.blackColor,
          leading: IconButton(
              onPressed: () {
                value.onBack();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: ThemeProvider.whiteColor,
              )),
        ),
        body: Stack(
          children: [
            VideoPlayerItem(
              videoUrl:
                  '${Environments.apiBaseURL}storage/video/${value.videoURL}',
              newsId: value.id.toString(),
              slugs: value.slug.toString(),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              value.title.toString(),
                              style: TextStyle(
                                  fontSize: value.defaultTitleSize,
                                  color: ThemeProvider.whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              value.shortDescriptions.toString(),
                              style: TextStyle(
                                fontSize: value.defaultDescriptionSize,
                                color: ThemeProvider.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            )
          ],
        ),
      );
    });
  }
}
