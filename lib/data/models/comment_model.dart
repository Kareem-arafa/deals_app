import 'package:dealz/data/models/user.dart';

class CommentModel {
  int? id;
  String? active;
  String? type;
  int? userId;
  int? contentId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  UserModel? user;

  CommentModel({
    this.id,
    this.active,
    this.type,
    this.userId,
    this.contentId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    type = json['type'];
    userId = json['user_id'];
    contentId = json['content_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['content_id'] = this.contentId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
