import 'package:dealz/data/models/feature_model.dart';
import 'package:dealz/data/models/store_details_model.dart';
import 'package:dealz/data/models/user.dart';

import 'comment_model.dart';

class MyAdsModel {
  int? id;
  String? titleAr;
  String? titleEn;
  String? title;
  String? descriptionAr;
  String? descriptionEn;
  List<IamgeModel>? images;
  num? price;
  String? phone;
  String? whatsApp;
  int? views;
  int? remainingDays;
  DateTime? createdAt;
  RatModel? rating;
  int? userId;
  List<CommentModel>? comments;
  UserModel? user;
  bool? inWishlist;
  List<FeatureModel>? features;
  List<AttributesValues>? attributesValues;
  String? long;
  String? lat;
  int? clicks;
  String? type;
  int? active;

  MyAdsModel({
    this.id,
    this.titleAr,
    this.titleEn,
    this.title,
    this.descriptionAr,
    this.descriptionEn,
    this.images,
    this.price,
    this.phone,
    this.whatsApp,
    this.views,
    this.createdAt,
    this.rating,
    this.userId,
    this.comments,
    this.user,
    this.remainingDays,
    this.inWishlist,
    this.lat,
    this.long,
    this.features,
    this.clicks,
    this.type,
    this.active,
    this.attributesValues,
  });

  MyAdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['ar_name'];
    titleEn = json['en_name'];
    title = json['name'] ?? json['title'];
    descriptionAr = json['ar_description'];
    descriptionEn = json['en_description'];
    phone = json['phone'];
    if (json['images'] != null) {
      images = <IamgeModel>[];
      json['images'].forEach((v) {
        images!.add(new IamgeModel.fromJson(v));
      });
    }
    price = json['price'];
    whatsApp = json['whatsapp'];
    views = json['views'];
    remainingDays = json['remainingDays'];
    lat = json['latitude'];
    long = json['longitude'];
    if (json['created_at'] != null) {
      createdAt = DateTime.parse(json['created_at']).toLocal();
    }
    rating = (json['ratings'] is List)
        ? null
        : json['ratings'] != null
            ? new RatModel.fromJson(json['ratings'])
            : null;
    userId = json['user_id'];
    if (json['comments'] != null) {
      comments = <CommentModel>[];
      json['comments'].forEach((v) {
        comments!.add(new CommentModel.fromJson(v));
      });
    }
    if (json['features'] != null) {
      features = <FeatureModel>[];
      json['features'].forEach((v) {
        features!.add(new FeatureModel.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributesValues = <AttributesValues>[];
      json['attributes'].forEach((v) {
        attributesValues!.add(AttributesValues.fromJson(v));
      });
    }
    if (json['user'] != null) {
      user = UserModel.fromJson(json['user']);
    }
    inWishlist = json['in_wishlist'];
    clicks = json['click'] ?? 0;
    type = json['type'];
    active = json['active'];
  }

  String getTitle(String locale) {
    if (type == "commercial") {
      if (locale == "ar") {
        return "اعلان تجاري";
      } else {
        return "Commercial Ads";
      }
    }
    if (locale == 'ar') {
      if (titleAr?.isEmpty ?? true) {
        return title ?? titleEn ?? '';
      } else {
        return title ?? titleAr ?? titleEn ?? '';
      }
    } else {
      return title ?? titleEn ?? '';
    }
  }

  String name(String locale) {
    if (type == "commercial") {
      if (locale == "ar") {
        return "اعلان تجاري";
      } else {
        return "Commercial Ads";
      }
    }
    if (locale == 'ar') {
      if (titleAr?.isEmpty ?? true) {
        return title ?? titleEn ?? '';
      } else {
        return title ?? titleAr ?? titleEn ?? '';
      }
    } else {
      return title ?? titleEn ?? '';
    }
  }

  String getDescription(String locale) {
    return descriptionEn ?? "";
  }
}

class IamgeModel {
  int? id;
  int? advertisementId;
  String? image;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  IamgeModel({this.id, this.advertisementId, this.image, this.createdAt, this.updatedAt});

  IamgeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisementId = json['advertisement_id'];
    image = json['image'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advertisement_id'] = this.advertisementId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class RatModel {
  num? rating;
  int? count;

  RatModel({this.rating, this.count});

  RatModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    count = json['count'];
  }
}

class AttributesValues {
  String? name;
  String? value;

  AttributesValues({this.name, this.value});

  AttributesValues.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }
}
