class ProductSizeModel {
  int? id;
  String? name;

  ProductSizeModel({
    this.id,
    this.name,
  });

  ProductSizeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
