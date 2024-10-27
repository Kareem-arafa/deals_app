class CategoryModel {
  final String? nameAr;
  final String? nameEn;
  final String? image;
  final int? id;

  CategoryModel({
    this.nameAr,
    this.nameEn,
    this.image,
    this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      nameAr: json['ar_name'],
      nameEn: json['en_name'],
      image: json['image'],
      id: json['id'],
    );
  }

  String name(String lang) {
    if (lang == 'ar') {
      return nameAr ?? '';
    } else {
      return nameEn ?? '';
    }
  }
}
