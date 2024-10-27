import 'dart:io';

import 'package:dio/dio.dart';

enum trendsTypes {
  store(value: "store", nameAr: "متجر", nameEn: "Store"),
  product(value: "product", nameAr: "منتج", nameEn: "Product"),
  ordinary(value: "ordinary", nameAr: "اعلان عادي", nameEn: "Ordinary Ads"),
  commercial(value: "commercial", nameAr: "اعلان تجاري", nameEn: "Commercial Ads"),
  none(value: "", nameAr: "لا يوجد", nameEn: "No Type");

  final String value;
  final String nameAr;
  final String nameEn;

  const trendsTypes({
    required this.value,
    required this.nameEn,
    required this.nameAr,
  });

  String name(String local) {
    if (local == 'ar') {
      return nameAr;
    } else {
      return nameEn;
    }
  }
}

enum trendsSize {
  big,
  small,
  vertical;
}

class CreateTrendAdsModel {
  String title;
  trendsTypes type;
  trendsSize size;
  int? packageId;
  int? contentId;
  File image;

  CreateTrendAdsModel({
    required this.title,
    required this.image,
    required this.type,
    required this.size,
    this.packageId,
    this.contentId,
  });

  FormData toJson() {
    Map<String, dynamic> data = {
      "title": title,
      "package_id": packageId,
      "size": size.name,
    };
    if (type.value.isNotEmpty) {
      data['type'] = type.value;
      data['id'] = contentId;
    }
    FormData formData = FormData.fromMap(data);

    formData.files.add(
      MapEntry(
        "image",
        MultipartFile.fromFileSync(image.path),
      ),
    );

    return formData;
  }
}
