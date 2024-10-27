import 'package:dealz/data/models/comment_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/data/models/my_store_model.dart' hide Rating;
import 'package:dealz/data/models/store_details_model.dart';
import 'package:dealz/data/models/user.dart';

class HomeModel {
  List<Sliders>? sliders;
  List<Stores>? stores;
  List<Sections>? sections;
  List<HomeProduct>? suggestionsSlider;
  List<HomeProduct>? recentlyAdded;

  HomeModel({
    this.sliders,
    this.stores,
    this.sections,
    this.suggestionsSlider,
    this.recentlyAdded,
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
    if (json['suggestions_slider'] != null) {
      suggestionsSlider = <HomeProduct>[];
      json['suggestions_slider'].forEach((v) {
        suggestionsSlider!.add(HomeProduct.fromJson(v));
      });
    }
    if (json['recently_added'] != null) {
      recentlyAdded = <HomeProduct>[];
      json['recently_added'].forEach((v) {
        recentlyAdded!.add(HomeProduct.fromJson(v));
      });
    }
  }
}

class Sliders {
  int? id;
  String? arabicName;
  String? englishName;
  String? arabicDescription;
  String? englishDescription;
  String? link;
  String? image;

  Sliders({
    this.id,
    this.arabicName,
    this.englishName,
    this.arabicDescription,
    this.englishDescription,
    this.link,
    this.image,
  });

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicName = json['arabic_name'];
    englishName = json['english_name'];
    arabicDescription = json['arabic_description'];
    englishDescription = json['english_description'];
    link = json['link'];
    image = json['image'];
  }
}

class Stores {
  int? id;
  int? sectionId;
  String? arabicName;
  String? englishName;
  String? arabicLogo;
  String? englishLogo;

  Stores({
    this.id,
    this.sectionId,
    this.arabicName,
    this.englishName,
    this.arabicLogo,
    this.englishLogo,
  });

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    arabicName = json['arabic_name'];
    englishName = json['english_name'];
    arabicLogo = json['arabic_logo'];
    englishLogo = json['english_logo'];
  }
}

class Sections {
  int? id;
  String? arabicName;
  String? englishName;
  int? sort;
  String? image;
  int? count;

  Sections({
    this.id,
    this.arabicName,
    this.englishName,
    this.sort,
    this.image,
    this.count,
  });

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicName = json['arabic_name'];
    englishName = json['english_name'];
    sort = json['sort'];
    image = json['image'];
    count = json['count'];
  }

  String name(String locale) {
    if (locale == 'ar') {
      return arabicName ?? '';
    } else {
      return englishName ?? '';
    }
  }
}

class HomeProduct {
  int? id;
  int? storeId;
  String? arabicName;
  String? englishName;
  String? arabicDescription;
  String? englishDescription;
  String? image;
  List<IamgeModel>? images;
  String? whatsApp;
  int? days;
  List<num>? prices;
  num? price;
  num? priceAfterDiscount;
  num? discount;
  String? currencyAr;
  String? currencyEn;
  String? featured;
  DateTime? createdAt;
  int? views;
  Rating? rating;
  int? userId;
  List<CommentModel>? comments;
  UserModel? user;
  bool? inWishlist;
  MyStoreModel? store;

  HomeProduct({
    this.id,
    this.storeId,
    this.arabicName,
    this.englishName,
    this.arabicDescription,
    this.englishDescription,
    this.image,
    this.days,
    this.prices,
    this.currencyAr,
    this.currencyEn,
    this.featured,
    this.createdAt,
    this.views,
    this.rating,
    this.userId,
    this.comments,
    this.user,
    this.whatsApp,
    this.images,
    this.inWishlist,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.store,
  });

  HomeProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    arabicName = json['arabic_name'];
    englishName = json['english_name'];
    arabicDescription = json['arabic_description'];
    englishDescription = json['english_description'];
    image = json['image'];
    days = json['days'];
    if (json['price'] is num) {
      price = json["price"];
    } else {
      if (json['price'] != null) {
        prices = <num>[];
        json['price'].forEach((v) {
          if (v != null) prices!.add(v);
        });
      }
    }

    currencyAr = json['currency_ar'];
    currencyEn = json['currency_en'];
    featured = json['featured'];
    if (json['created_at'] != null) {
      createdAt = DateTime.parse(json['created_at']).toLocal();
    }
    if (json['comments'] != null) {
      comments = <CommentModel>[];
      json['comments'].forEach((v) {
        comments!.add(new CommentModel.fromJson(v));
      });
    }
    if (json['user'] != null) {
      user = UserModel.fromJson(json['user']);
    }
    if (json['store'] != null) {
      store = MyStoreModel.fromJson(json['store']);
    }
    whatsApp = json['whatsapp'];
    inWishlist = json['in_wishlist'];
    priceAfterDiscount = json['after_discount'];
    discount = json['discount'];
  }

  String getName(String local) {
    if (local == "ar") {
      return arabicName ?? "";
    } else {
      return englishName ?? "";
    }
  }

  String getDescription(String local) {
    if (local == "ar") {
      return arabicDescription ?? "";
    } else {
      return englishDescription ?? "";
    }
  }
}
