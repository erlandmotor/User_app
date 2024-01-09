import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiService extends GetxService {
  final String appBaseUrl;

  static const String connectionIssue = 'Connection failed!';
  final int timeoutInSeconds = 30;

  ApiService({required this.appBaseUrl});

  Future<Response> getPublic(String uri) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(appBaseUrl + uri),
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> getPrivate(String uri, String token) async {
    try {
      http.Response response = await http.get(Uri.parse(appBaseUrl + uri),
          headers: {
            'Content-Type': 'application/json;',
            'Authorization': 'Bearer $token'
          }).timeout(Duration(seconds: timeoutInSeconds));
      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> uploadFiles(
    String uri,
    List<MultipartBody> multipartBody,
  ) async {
    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      for (MultipartBody multipart in multipartBody) {
        File file = File(multipart.file.path);
        request.files.add(http.MultipartFile(
          multipart.key,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ));
      }
      http.Response response =
          await http.Response.fromStream(await request.send());
      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> postPublic(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse(appBaseUrl + uri),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body),
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return parseResponse(response, appBaseUrl + uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> postPrivate(
    String uri,
    dynamic body,
    String token,
  ) async {
    try {
      http.Response response = await http.post(Uri.parse(appBaseUrl + uri),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }).timeout(Duration(seconds: timeoutInSeconds));
      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> logout(
    String uri,
    String token,
  ) async {
    try {
      http.Response response = await http.post(Uri.parse(appBaseUrl + uri),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }).timeout(Duration(seconds: timeoutInSeconds));
      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Response parseResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      e;
    }
    Response res = Response(
      body: body != '' ? body : response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (res.statusCode != 200 && res.body != null && res.body is! String) {
      if (res.body.toString().startsWith('{errors: [{code:')) {
        res = Response(
            statusCode: res.statusCode, body: res.body, statusText: 'error');
      } else if (res.body.toString().startsWith('{message')) {
        res = Response(
            statusCode: res.statusCode,
            body: res.body,
            statusText: res.body['message']);
      }
    } else if (res.statusCode != 200 && res.body == null) {
      res = const Response(statusCode: 0, statusText: connectionIssue);
    }
    return res;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
