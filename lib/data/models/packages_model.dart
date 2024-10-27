class PackageModel {
  int? id;
  String? active;
  num? price;
  int? duration;
  String? enName;
  String? arName;
  String? image;
  String? featured;
  String? pinInProductList;
  String? pinInCategories;
  int? pushedOnTop;
  String? createdAt;
  String? updatedAt;

  PackageModel({
    this.id,
    this.active,
    this.price,
    this.duration,
    this.enName,
    this.arName,
    this.image,
    this.featured,
    this.pinInProductList,
    this.pinInCategories,
    this.pushedOnTop,
    this.createdAt,
    this.updatedAt,
  });

  PackageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    price = json['price'];
    duration = json['duration'];
    enName = json['en_name'];
    arName = json['ar_name'];
    image = json['image'];
    featured = json['featured'];
    pinInProductList = json['pin_in_product_list'];
    pinInCategories = json['pin_in_categories'];
    pushedOnTop = json['pushed_on_top'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  String name(String local) {
    if (local == 'ar') {
      return arName ?? "";
    } else {
      return enName ?? "";
    }
  }
}
