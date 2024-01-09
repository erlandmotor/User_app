class SavedNewsModel {
  int? id;
  int? newsId;
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
  String? uid;
  bool? haveLiked;

  SavedNewsModel(
      {this.id,
      this.newsId,
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
      this.uid,
      this.haveLiked});

  SavedNewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsId = json['news_id'];
    cateId = json['cate_id'];
    comments = json['comments'];
    content = json['content'];
    cover = json['cover'];
    createdAt = json['created_at'];
    extraField = json['extra_field'];
    likes = json['likes'];
    shareContent = json['share_content'];
    shortDescriptions = json['short_descriptions'];
    urlSlugs = json['url_slugs'];
    status = json['status'];
    title = json['title'];
    translations = json['translations'];
    videoUrl = json['video_url'];
    cateName = json['cate_name'];
    cateTranslations = json['cate_translations'];
    titleColor = json['title_color'];
    cityName = json['city_name'];
    authorFirstName = json['author_first_name'];
    authorLastName = json['author_last_name'];
    uid = json['uid'];
    haveLiked = json['haveLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['news_id'] = newsId;
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
    data['uid'] = uid;
    data['haveLiked'] = haveLiked;
    return data;
  }
}
