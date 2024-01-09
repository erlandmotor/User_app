import 'package:get/get.dart';
import 'package:ultimate_news/app/controller/comments_controller.dart';

class CommentsBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => CommentsController(parser: Get.find()),
    );
  }
}
