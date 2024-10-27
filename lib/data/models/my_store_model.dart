import 'package:dealz/data/models/days_model.dart';

class MyStoreModel {
  int? id;
  int? userId;
  String? type;
  int? sectionId;
  int? packageId;
  String? name;
  String? logo;
  String? phone;
  String? whatsapp;
  String? active;
  String? description;
  int? categoryId;
  String? commercialRecord;
  String? instagramLink;
  String? facebookLink;
  String? tiktokLink;
  String? snapchatLink;
  String? youtubeLink;
  List<String>? availableDays;
  String? openingTime;
  String? closingTime;
  int? cityId;
  bool? inWishlist;
  int? followers;
  int? views;
  Rating? rating;
  bool? isFollowing;
  int? remainingDays;

  MyStoreModel({
    this.id,
    this.userId,
    this.type,
    this.sectionId,
    this.packageId,
    this.name,
    this.logo,
    this.phone,
    this.whatsapp,
    this.active,
    this.description,
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
    this.inWishlist,
    this.followers,
    this.views,
    this.rating,
    this.isFollowing,
    this.remainingDays,
  });

  MyStoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    sectionId = json['section_id'];
    packageId = json['package_id'];
    name = json['name'];
    logo = json['logo'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    active = json['active'];
    description = json['description'];
    categoryId = json['category_id'];
    commercialRecord = json['commercial_record'];
    instagramLink = json['instagram_link'];
    facebookLink = json['facebook_link'];
    tiktokLink = json['tiktok_link'];
    snapchatLink = json['snapchat_link'];
    youtubeLink = json['youtube_link'];
    availableDays = json['available_days']?.cast<String>();
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    cityId = json['city_id'];
    inWishlist = json['in_wishlist'];
    followers = json['followers'];
    views = json['views'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    isFollowing = json['is_following'];
    remainingDays = json['remaining_days'];
  }

  List<DaysModel> getSelectedDays() {
    final List<DaysModel> selectedDays = [];
    availableDays?.forEach((day) {
      days.forEach((element) {
        if (day == element.englishName || day == element.arabicName) {
          selectedDays.add(element);
        }
      });
    });

    return selectedDays;
  }
}

class Rating {
  int? rating;
  int? count;

  Rating({this.rating, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    count = json['count'];
  }
}
