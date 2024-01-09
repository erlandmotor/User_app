class CommentsModel {
  int? id;
  String? comments;
  int? status;
  String? firstName;
  int? uid;
  String? lastName;

  CommentsModel(
      {this.id,
      this.comments,
      this.status,
      this.firstName,
      this.uid,
      this.lastName});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    status = json['status'];
    firstName = json['first_name'];
    uid = json['uid'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comments'] = comments;
    data['status'] = status;
    data['first_name'] = firstName;
    data['uid'] = uid;
    data['last_name'] = lastName;
    return data;
  }
}
