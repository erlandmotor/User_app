class SearchResultModel {
  int? id;
  String? title;
  String? cover;
  String? urlSlugs;
  String? translations;
  String? videoUrl;

  SearchResultModel(
      {this.id,
      this.title,
      this.cover,
      this.urlSlugs,
      this.translations,
      this.videoUrl});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    urlSlugs = json['url_slugs'];
    translations = json['translations'];
    videoUrl = json['video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['cover'] = cover;
    data['url_slugs'] = urlSlugs;
    data['translations'] = translations;
    data['video_url'] = videoUrl;
    return data;
  }
}
