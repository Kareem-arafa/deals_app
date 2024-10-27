import 'dart:io';

import 'package:dio/dio.dart';

class CreateCommercialAdsModel {
  String phone;
  String whatsapp;
  int? packageId;
  File image;
  int? sectionId;

  CreateCommercialAdsModel({
    required this.phone,
    required this.whatsapp,
    required this.image,
    this.packageId,
    this.sectionId,
  });

  FormData toJson() {
    Map<String, dynamic> data = {
      "phone": phone,
      "whatsapp": whatsapp,
      "package_id": packageId,
    };
    if (sectionId != null) {
      data['section_id'] = sectionId;
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
