class CommercialAdsModel {
  int? id;
  String? whatsapp;
  String? phone;
  List<Images>? images;

  CommercialAdsModel({this.id, this.whatsapp, this.phone, this.images});

  CommercialAdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    whatsapp = json['whatsapp'];
    phone = json['phone'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }
}

class Images {
  int? id;
  int? advertisementId;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Images({
    this.id,
    this.advertisementId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisementId = json['advertisement_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
  }
}
