class PageModel {
  int? id;
  String? identifier;
  String? arTitle;
  String? enTitle;
  String? arDesc;
  String? enDesc;
  String? image;
  String? createdAt;
  String? updatedAt;

  PageModel({
    this.id,
    this.identifier,
    this.arTitle,
    this.enTitle,
    this.arDesc,
    this.enDesc,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  PageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    identifier = json['identifier'];
    arTitle = json['ar_title'];
    enTitle = json['en_title'];
    arDesc = json['ar_desc'];
    enDesc = json['en_desc'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['identifier'] = this.identifier;
    data['ar_title'] = this.arTitle;
    data['en_title'] = this.enTitle;
    data['ar_desc'] = this.arDesc;
    data['en_desc'] = this.enDesc;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  String getTitle(String locale) {
    if (locale == 'ar') {
      return arTitle!;
    } else {
      return enTitle!;
    }
  }

  String getDesc(String locale) {
    if (locale == 'ar') {
      return arDesc!;
    } else {
      return enDesc!;
    }
  }
}
