class TrendAdsModel {
  int? id;
  String? title;
  int? sourceId;
  String? sourceType;
  String? size;
  String? imageUrl;
  String? createdAt;

  TrendAdsModel({
    this.id,
    this.title,
    this.sourceId,
    this.sourceType,
    this.size,
    this.imageUrl,
    this.createdAt,
  });

  TrendAdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    sourceId = json['source_id'];
    sourceType = json['source_type'];
    size = json['size'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
  }
}
