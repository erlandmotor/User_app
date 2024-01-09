import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/parse/pages_parse.dart';

class PagesController extends GetxController implements GetxService {
  final PagesParser parser;
  String pageName = '';
  String pageId = '';
  String content = '';
  bool apiCalled = false;
  PagesController({required this.parser});

  @override
  void onInit() async {
    super.onInit();
    var name = Get.arguments[0];
    var dbPageId = Get.arguments[1];
    pageName = name;
    pageId = dbPageId;
    update();
    getContent();
  }

  Future<void> getContent() async {
    Response response = await parser.getContentById(pageId);
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body['content'] != '' && body['content'] != null) {
        content = body['content'];
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }
}
