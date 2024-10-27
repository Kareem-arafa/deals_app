import 'dart:io';

import 'package:dealz/data/models/feature_model.dart';
import 'package:dio/dio.dart';
import 'package:collection/collection.dart';

class CreateOrdinaryAdsModel {
  String description;
  String title;
  String whatsApp;
  String? price;
  List<File> images;
  int sectionId;
  int categoryId;
  int cityId;
  int stateId;
  int? packageId;
  List<FeatureModel>? features;
  bool showInSpecialAds;
  double? lang;
  double? lat;
  List<AttributesModel> attributes;

  CreateOrdinaryAdsModel({
    required this.description,
    required this.title,
    required this.whatsApp,
    required this.images,
    required this.sectionId,
    required this.cityId,
    required this.stateId,
    this.price,
    required this.showInSpecialAds,
    required this.categoryId,
    this.packageId,
    this.lang,
    this.lat,
    this.features,
    required this.attributes,
  });

  FormData toJson() {
    final Map<String, dynamic> data = {
      'description': description,
      'title': title,
      'whatsapp': whatsApp,
      'section_id': sectionId,
      'category_id': categoryId,
      'city_id': cityId,
      'state_id': stateId,
      'package_id': packageId,
      'special': showInSpecialAds ? 1 : 0,
    };
    if (price != null) data['price'] = price;
    if (lat != null) data['lat'] = lat;
    if (lang != null) data['lng'] = lang;

    if (attributes.isNotEmpty) {
      attributes.forEach((element) {
        data.addAll(element.toJson());
      });
    }

    final FormData formData = FormData.fromMap(data);
    if (images.isNotEmpty) {
      formData.files.addAll(
        images.mapIndexed((index, image) => MapEntry("images[$index]", MultipartFile.fromFileSync(image.path))),
      );
    }
    if (features != null) {
      if (features!.isNotEmpty) {
        formData.fields.addAll(
          features!.mapIndexed((index, feature) => MapEntry("features[$index]", feature.id.toString())),
        );
      }
    }
    return formData;
  }
}

class AttributesModel {
  int attributeId;
  var attributeValue;

  AttributesModel({
    required this.attributeId,
    required this.attributeValue,
  });

  Map<String, dynamic> toJson() {
    return {
      "attributes[$attributeId]": attributeValue,
    };
  }
}
