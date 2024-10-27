class SizeModel {
  String? size;
  num? price;

  SizeModel({this.size, this.price});

  SizeModel.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    price = json['price'];
  }
}
