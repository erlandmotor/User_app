import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/api/handler.dart';
import 'package:ultimate_news/app/backend/models/comments_model.dart';
import 'package:ultimate_news/app/backend/parse/comments_parse.dart';
import 'package:ultimate_news/app/util/toast.dart';

class CommentsController extends GetxController implements GetxService {
  final CommentsParser parser;

  final commentsEditor = TextEditingController();
  var newsId = '';
  RxBool isLogin = false.obs;
  bool commentsCalled = false;

  List<CommentsModel> _comments = <CommentsModel>[];
  List<CommentsModel> get comments => _comments;
  CommentsController({required this.parser});

  @override
  void onInit() async {
    super.onInit();
    var id = Get.arguments[0];
    newsId = id.toString();
    getComments();
  }

  Future<void> saveComments() async {
    if (parser.haveAccount() == true) {
      if (commentsEditor.text == '') {
        showToast('Please add comments');
        return;
      }
      isLogin.value = !isLogin.value;
      var param = {
        'uid': parser.getUID(),
        'news_id': newsId,
        'comments': commentsEditor.text,
        'status': '1'
      };
      Response response = await parser.saveComments(param);
      if (response.statusCode == 200) {
        isLogin.value = !isLogin.value;
        commentsEditor.text = '';
        update();
        getComments();
      }
    } else {
      showToast('Sign In / Sign Up');
    }
  }

  Future<void> getComments() async {
    commentsCalled = false;
    Response response = await parser.getComments(newsId);
    if (response.statusCode == 200) {
      commentsCalled = true;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      _comments = [];
      body.forEach((order) {
        CommentsModel data = CommentsModel.fromJson(order);
        _comments.add(data);
      });
    } else {
      commentsCalled = true;
      ApiChecker.checkApi(response);
    }
    update();
  }
}
