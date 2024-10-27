class CommercialStoreModel {
  int? id;
  int? userId;
  String? type;
  int? sectionId;
  String? arName;
  String? enName;
  String? arLogo;
  String? enLogo;
  String? phone;
  String? whatsapp;
  String? active;
  String? createdAt;
  String? updatedAt;
  int? verified;
  String? enDescription;
  String? arDescription;
  int? categoryId;
  String? commercialRecord;
  String? instagramLink;
  String? facebookLink;
  String? tiktokLink;
  String? snapchatLink;
  String? youtubeLink;
  String? availableDays;
  String? openingTime;
  String? closingTime;
  int? cityId;
  List<Images>? images;
  String? logo;

  CommercialStoreModel({
    this.id,
    this.userId,
    this.type,
    this.sectionId,
    this.arName,
    this.enName,
    this.arLogo,
    this.enLogo,
    this.phone,
    this.whatsapp,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.verified,
    this.enDescription,
    this.arDescription,
    this.categoryId,
    this.commercialRecord,
    this.instagramLink,
    this.facebookLink,
    this.tiktokLink,
    this.snapchatLink,
    this.youtubeLink,
    this.availableDays,
    this.openingTime,
    this.closingTime,
    this.cityId,
    this.images,
    this.logo,
  });

  CommercialStoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    sectionId = json['section_id'];
    arName = json['ar_name'];
    enName = json['en_name'];
    arLogo = json['ar_logo'];
    enLogo = json['en_logo'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    verified = json['verified'];
    enDescription = json['en_description'];
    arDescription = json['ar_description'];
    categoryId = json['category_id'];
    commercialRecord = json['commercial_record'];
    instagramLink = json['instagram_link'];
    facebookLink = json['facebook_link'];
    tiktokLink = json['tiktok_link'];
    snapchatLink = json['snapchat_link'];
    youtubeLink = json['youtube_link'];
    availableDays = json['available_days'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    logo = json['logo'];
    cityId = json['city_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  String getName(String locale) {
    return enName ?? "";
  }

  String name(String locale) {
    return enName ?? "";
  }

  String getDescription(String locale) {
    return enDescription ?? "";
  }
}

class Images {
  int? id;
  int? storeId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Images({this.id, this.storeId, this.image, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
