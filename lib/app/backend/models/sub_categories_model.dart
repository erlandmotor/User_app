class SubCategoriesModel {
  int? id;
  int? cateId;
  String? name;
  String? urlSlugs;
  int? orderId;
  String? cover;
  String? translations;
  String? extraField;
  int? status;
  String? createdAt;
  String? updatedAt;

  SubCategoriesModel(
      {this.id,
      this.cateId,
      this.name,
      this.urlSlugs,
      this.orderId,
      this.cover,
      this.translations,
      this.extraField,
      this.status,
      this.createdAt,
      this.updatedAt});

  SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cateId = json['cate_id'];
    name = json['name'];
    urlSlugs = json['url_slugs'];
    orderId = json['order_id'];
    cover = json['cover'];
    translations = json['translations'];
    extraField = json['extra_field'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cate_id'] = cateId;
    data['name'] = name;
    data['url_slugs'] = urlSlugs;
    data['order_id'] = orderId;
    data['cover'] = cover;
    data['translations'] = translations;
    data['extra_field'] = extraField;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
