import 'package:ultimate_news/app/backend/models/sub_categories_model.dart';

class CategoriesModel {
  int? id;
  String? name;
  String? titleColor;
  String? urlSlugs;
  int? orderId;
  String? cover;
  String? translations;
  String? extraField;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<SubCategoriesModel>? subCates;

  CategoriesModel(
      {this.id,
      this.name,
      this.titleColor,
      this.urlSlugs,
      this.orderId,
      this.cover,
      this.translations,
      this.extraField,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.subCates});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    titleColor = json['title_color'];
    urlSlugs = json['url_slugs'];
    orderId = int.parse(json['order_id'].toString());
    cover = json['cover'];
    translations = json['translations'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subCates'] != null) {
      subCates = <SubCategoriesModel>[];
      json['subCates'].forEach((v) {
        subCates!.add(SubCategoriesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['title_color'] = titleColor;
    data['url_slugs'] = urlSlugs;
    data['order_id'] = orderId;
    data['cover'] = cover;
    data['translations'] = translations;
    data['extra_field'] = extraField;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subCates != null) {
      data['subCates'] = subCates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
