import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:collection/collection.dart';

class CreateStoreModel {
  String name;
  String description;
  int categoryId;
  int sectionId;
  String phone;
  File? logo;
  int cityId;
  List<String> availableDays;
  String openTime;
  String closeTime;
  String whatsapp;
  File? commercialRecord;
  String? instagramLink;
  String? facebookLink;
  String? tiktokLink;
  String? snapchatLink;
  String? youtubeLink;
  int? packageId;

  CreateStoreModel({
    required this.name,
    required this.description,
    required this.categoryId,
    required this.sectionId,
    required this.phone,
    required this.cityId,
    required this.availableDays,
    required this.openTime,
    required this.closeTime,
    required this.whatsapp,
    required this.instagramLink,
    this.logo,
    this.commercialRecord,
    this.facebookLink,
    this.tiktokLink,
    this.snapchatLink,
    this.youtubeLink,
    this.packageId,
  });

  FormData toJson(bool isUpdate) {
    final Map<String, dynamic> data = {
      "name": name,
      "description": description,
      "category_id": categoryId,
      "section_id": sectionId,
      "phone": phone,
      "city_id": cityId,
      "opening_time": openTime,
      "closing_time": closeTime,
      "whatsapp": whatsapp,
      "instagram": instagramLink,
      "facebook": facebookLink,
      "tiktok": tiktokLink,
      "snapchat": snapchatLink,
      "youtube": youtubeLink,
      "package_id": packageId,
    };

    if (availableDays.isNotEmpty) {
      availableDays.forEachIndexed((index, element) {
        data['available_days[$index]'] = element;
      });
    }

    if (isUpdate) {
      data['_method'] = "PUT";
    }
    final FormData formData = FormData.fromMap(data);

    if (commercialRecord != null) {
      formData.files.add(
        MapEntry("commercial_record", MultipartFile.fromFileSync(commercialRecord!.path)),
      );
    }
    if (logo != null)
      formData.files.add(
        MapEntry("logo", MultipartFile.fromFileSync(logo!.path)),
      );

    return formData;
  }
}
