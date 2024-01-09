import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ultimate_news/app/controller/video_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/video_player.dart';
import 'package:ultimate_news/app/util/theme.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(builder: (value) {
      return Scaffold(
        body: value.news.isEmpty && value.newsCalled == true
            ? Center(
                child: Text('No Data Found'.tr),
              )
            : PageView.builder(
                itemCount: value.news.length,
                controller: PageController(initialPage: 0, viewportFraction: 1),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final data = value.news[index];
                  return Stack(
                    children: [
                      VideoPlayerItem(
                        videoUrl:
                            '${Environments.apiBaseURL}storage/video/${data.videoUrl}',
                        newsId: data.id.toString(),
                        slugs: data.urlSlugs.toString(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        data.title.toString(),
                                        style: TextStyle(
                                            fontSize: value.defaultTitleSize,
                                            color: ThemeProvider.whiteColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        data.shortDescriptions.toString(),
                                        style: TextStyle(
                                          fontSize:
                                              value.defaultDescriptionSize,
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
                  );
                }),
        bottomNavigationBar: Container(
          height: value.myBanner.size.height.toDouble(),
          color: Colors.transparent,
          child: AdWidget(ad: value.myBanner),
        ),
      );
    });
  }
}
