import 'dart:io';

import 'package:dio/dio.dart';

class StoreProductModel {
  int? id;
  String? title;
  String? description;
  num? price;
  num? priceAfterDiscount;
  bool? hasDiscount;
  num? discount;
  List<ImageModel>? images;
  List<File>? imagesFile;

  StoreProductModel({
    this.id,
    this.title,
    this.description,
    this.images,
    this.price,
    this.imagesFile,
    this.discount,
    this.hasDiscount,
    this.priceAfterDiscount,
  });

  StoreProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['name'];
    description = json['description'];
    price = json['price'];
    priceAfterDiscount = json['after_discount'];
    priceAfterDiscount = json['after_discount'];
    hasDiscount = json['has_discount'];
    discount = json['discount'];
    if (json['images'] != null) {
      images = <ImageModel>[];
      for (var image in (json['images'] as List)) {
        images!.add(ImageModel.fromJson(image));
      }
    }
  }

  FormData toJson({required bool isUpdate}) {
    Map<String, dynamic> data = {
      "name": title,
      "description": description,
      'discount': discount ?? 0,
    };
    if (price != null) {
      data['price'] = price;
    }
    if (isUpdate) {
      data['_method'] = "PUT";
    }
    FormData formData = FormData.fromMap(data);
    if (imagesFile?.isNotEmpty ?? false) {
      formData.files.addAll(
        imagesFile!.map(
          (image) => MapEntry(
            "images[]",
            MultipartFile.fromFileSync(image.path),
          ),
        ),
      );
    }

    return formData;
  }

  String name(String local) {
    return title ?? "";
  }
}

class ImageModel {
  int? id;
  String? image;

  ImageModel(this.id, this.image);

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
