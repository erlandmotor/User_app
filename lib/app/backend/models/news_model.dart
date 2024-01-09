import 'package:jiffy/jiffy.dart';

class NewsModel {
  int? id;
  int? cateId;
  int? comments;
  String? content;
  String? cover;
  String? createdAt;
  String? extraField;
  int? likes;
  String? shareContent;
  String? shortDescriptions;
  String? urlSlugs;
  int? status;
  String? title;
  String? translations;
  String? videoUrl;
  String? cateName;
  String? cateTranslations;
  String? titleColor;
  String? cityName;
  String? authorFirstName;
  String? authorLastName;
  bool? haveLiked;
  bool? haveSaved;

  NewsModel(
      {this.id,
      this.cateId,
      this.comments,
      this.content,
      this.cover,
      this.createdAt,
      this.extraField,
      this.likes,
      this.shareContent,
      this.shortDescriptions,
      this.urlSlugs,
      this.status,
      this.title,
      this.translations,
      this.videoUrl,
      this.cateName,
      this.cateTranslations,
      this.titleColor,
      this.cityName,
      this.authorFirstName,
      this.authorLastName,
      this.haveLiked,
      this.haveSaved});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    cateId = int.parse(json['cate_id'].toString());
    comments = int.parse(json['comments'].toString());
    content = json['content'];
    cover = json['cover'];
    createdAt = Jiffy(json['created_at'].toString()).fromNow().toString();
    extraField = json['extra_field'];
    likes = int.parse(json['likes'].toString());
    shareContent = json['share_content'];
    shortDescriptions = json['short_descriptions'];
    urlSlugs = json['url_slugs'];
    status = int.parse(json['status'].toString());
    title = json['title'];
    translations = json['translations'];
    videoUrl = json['video_url'];
    cateName = json['cate_name'];
    cateTranslations = json['cate_translations'];
    titleColor = json['title_color'];
    cityName = json['city_name'];
    authorFirstName = json['author_first_name'];
    authorLastName = json['author_last_name'];
    haveLiked = json['haveLiked'];
    haveSaved = json['haveSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cate_id'] = cateId;
    data['comments'] = comments;
    data['content'] = content;
    data['cover'] = cover;
    data['created_at'] = createdAt;
    data['extra_field'] = extraField;
    data['likes'] = likes;
    data['share_content'] = shareContent;
    data['short_descriptions'] = shortDescriptions;
    data['url_slugs'] = urlSlugs;
    data['status'] = status;
    data['title'] = title;
    data['translations'] = translations;
    data['video_url'] = videoUrl;
    data['cate_name'] = cateName;
    data['cate_translations'] = cateTranslations;
    data['title_color'] = titleColor;
    data['city_name'] = cityName;
    data['author_first_name'] = authorFirstName;
    data['author_last_name'] = authorLastName;
    data['haveLiked'] = haveLiked;
    data['haveSaved'] = haveSaved;
    return data;
  }
}
