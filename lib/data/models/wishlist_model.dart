import 'package:dealz/data/models/my_ads_model.dart';

class WishListModel {
  int? id;
  int? userId;
  int? contentId;
  String? type;
  String? createdAt;
  String? updatedAt;
  MyAdsModel? myAdsModel;

  WishListModel({
    this.id,
    this.userId,
    this.contentId,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  WishListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    contentId = json['content_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    myAdsModel = MyAdsModel.fromJson(json['advertisement']);
  }
  
}
