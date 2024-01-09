import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ultimate_news/app/controller/details_controller.dart';
import 'package:ultimate_news/app/controller/search_controller.dart';
import 'package:ultimate_news/app/env.dart';
import 'package:ultimate_news/app/helper/router.dart';
import 'package:ultimate_news/app/helper/theme_color.dart';
import 'package:ultimate_news/app/util/theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppSearchController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeColorsHelper.getBackgroundColor(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: ThemeColorsHelper.getBackgroundColor(),
            automaticallyImplyLeading: false,
            elevation: 0,
            title: TextField(
              controller: value.searchController,
              onChanged: value.searchNews,
              style: const TextStyle(
                  color: ThemeProvider.blackColor, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search'.tr,
                prefixIcon: const Icon(Icons.search),
                hintStyle: TextStyle(color: ThemeProvider.greyColor.shade600),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: ThemeColorsHelper.getBackgroundColor(),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: ThemeColorsHelper.getShadeColor(),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: ThemeColorsHelper.getShadeColor(),
                  ),
                ),
                filled: true,
                fillColor: ThemeColorsHelper.getShadeColor(),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              ),
            ),
          ),
        ),
        body: value.isEmpty == false && value.news.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                    children: List.generate(
                        value.news.length,
                        (index) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Get.delete<DetailsController>(force: true);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Get.toNamed(AppRouter.getDetailsRoutes(),
                                      arguments: [
                                        value.news[index].id.toString(),
                                        value.news[index].urlSlugs.toString()
                                      ]);
                                },
                                child: ListTile(
                                  leading: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: value.news[index].videoUrl != 'NA'
                                          ? Stack(
                                              children: <Widget>[
                                                FadeInImage(
                                                  height: 80,
                                                  width: 80,
                                                  image: NetworkImage(
                                                      '${Environments.apiBaseURL}storage/images/${value.news[index].cover}'),
                                                  placeholder: const AssetImage(
                                                      "assets/images/placeholder.jpeg"),
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    return Image.asset(
                                                        'assets/images/placeholder.jpeg',
                                                        height: 80,
                                                        width: 80,
                                                        fit: BoxFit.fitWidth);
                                                  },
                                                  fit: BoxFit.fitWidth,
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                    'assets/images/play-button.png',
                                                    height: 20,
                                                    width: 20,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              ],
                                            )
                                          : FadeInImage(
                                              height: 80,
                                              width: 80,
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${value.news[index].cover}'),
                                              placeholder: const AssetImage(
                                                  "assets/images/placeholder.jpeg"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    'assets/images/placeholder.jpeg',
                                                    height: 80,
                                                    width: 80,
                                                    fit: BoxFit.fitWidth);
                                              },
                                              fit: BoxFit.fitWidth,
                                            )),
                                  title: Text(
                                    value.news[index].title.toString(),
                                    style: TextStyle(
                                        fontSize: value.defaultTitleSize,
                                        color:
                                            ThemeColorsHelper.getFontColor()),
                                  ),
                                ),
                              ),
                            ))),
              )
            : Container(),
        bottomNavigationBar: Container(
          height: value.myBanner.size.height.toDouble(),
          color: Colors.transparent,
          child: AdWidget(ad: value.myBanner),
        ),
      );
    });
  }
}
