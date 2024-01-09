class BannersModel {
  int? id;
  String? cover;
  int? type;
  int? position;
  String? value;
  String? text;
  String? startTime;
  String? endTime;
  String? extraField;
  int? status;
  String? createdAt;
  String? updatedAt;

  BannersModel(
      {this.id,
      this.cover,
      this.type,
      this.position,
      this.value,
      this.text,
      this.startTime,
      this.endTime,
      this.extraField,
      this.status,
      this.createdAt,
      this.updatedAt});

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    cover = json['cover'];
    type = int.parse(json['type'].toString());
    position = int.parse(json['position'].toString());
    value = json['value'];
    text = json['text'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cover'] = cover;
    data['type'] = type;
    data['position'] = position;
    data['value'] = value;
    data['text'] = text;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['extra_field'] = extraField;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
