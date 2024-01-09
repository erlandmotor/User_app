import 'package:flutter/material.dart';
import 'package:ultimate_news/app/controller/details_controller.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/util/theme.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String newsId;
  final String slugs;
  const VideoPlayerItem(
      {super.key,
      required this.videoUrl,
      required this.newsId,
      required this.slugs});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;

  bool isPaused = false;
  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((value) => {
                videoPlayerController.play(),
                videoPlayerController.setVolume(1),
              });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: ThemeProvider.blackColor,
      ),
      child: Stack(children: <Widget>[
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                // If the video is playing, pause it.
                if (videoPlayerController.value.isPlaying) {
                  videoPlayerController.pause();
                  isPaused = true;
                } else {
                  videoPlayerController.play();
                  isPaused = false;
                }
              });
            },
            child: IgnorePointer(
              ignoring: true,
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: VideoPlayer(videoPlayerController),
              ),
            )),
        const ClosedCaption(
          text: null,
        ),
        isPaused == true
            ? const Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.pause_circle_outline,
                      color: ThemeProvider.whiteColor,
                      size: 40,
                    )),
              )
            : const SizedBox(),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: 100,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  height: 60,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 5,
                        top: 10,
                        child: Container(
                            width: 100,
                            height: 50,
                            color: ThemeProvider.appColor,
                            padding: const EdgeInsets.all(1),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.delete<DetailsController>(force: true);
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.toNamed(AppRouter.getDetailsRoutes(),
                                    arguments: [
                                      widget.newsId.toString(),
                                      widget.slugs.toString()
                                    ]);
                              },
                              child: Text(
                                'Read'.tr,
                                style: const TextStyle(
                                    color: ThemeProvider.whiteColor,
                                    fontSize: 13,
                                    fontFamily: 'bold'),
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            VideoProgressIndicator(
              videoPlayerController,
              allowScrubbing: true,
              padding: const EdgeInsets.all(3),
              colors: const VideoProgressColors(
                  playedColor: ThemeProvider.whiteColor),
            )
          ],
        ),
      ]),
    );
  }
}
