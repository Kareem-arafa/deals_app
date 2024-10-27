class StoreDetailsModel {
  int? id;
  int? sectionId;
  String? arabicName;
  String? englishName;
  List<String>? arabicCover;
  List<String>? englishCover;
  String? arabicLogo;
  String? englishLogo;
  int? verified;
  String? enDescription;
  String? arDescription;
  String? date;
  int? followers;
  int? views;
  Rating? rating;
  String? enCurrency;
  String? arCurrency;

  StoreDetailsModel({
    this.id,
    this.sectionId,
    this.arabicName,
    this.englishName,
    this.arabicCover,
    this.englishCover,
    this.arabicLogo,
    this.englishLogo,
    this.verified,
    this.enDescription,
    this.arDescription,
    this.date,
    this.followers,
    this.views,
    this.rating,
    this.enCurrency,
    this.arCurrency,
  });

  StoreDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    arabicName = json['arabic_name'];
    englishName = json['english_name'];
    arabicCover = json['arabic_cover'].cast<String>();
    englishCover = json['english_cover'].cast<String>();
    arabicLogo = json['arabic_logo'];
    englishLogo = json['english_logo'];
    verified = json['verified'];
    enDescription = json['en_description'];
    arDescription = json['ar_description'];
    date = json['date'];
    followers = json['followers'];
    views = json['views'];
    rating = json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    enCurrency = json['en_currency'];
    arCurrency = json['ar_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['section_id'] = this.sectionId;
    data['arabic_name'] = this.arabicName;
    data['english_name'] = this.englishName;
    data['arabic_cover'] = this.arabicCover;
    data['english_cover'] = this.englishCover;
    data['arabic_logo'] = this.arabicLogo;
    data['english_logo'] = this.englishLogo;
    data['verified'] = this.verified;
    data['en_description'] = this.enDescription;
    data['ar_description'] = this.arDescription;
    data['date'] = this.date;
    data['followers'] = this.followers;
    data['views'] = this.views;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    data['en_currency'] = this.enCurrency;
    data['ar_currency'] = this.arCurrency;
    return data;
  }
}

class Rating {
  int? votes;
  num? stars;

  Rating({this.votes, this.stars});

  Rating.fromJson(Map<String, dynamic> json) {
    votes = json['votes'];
    stars = json['stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['votes'] = this.votes;
    data['stars'] = this.stars;
    return data;
  }
}
