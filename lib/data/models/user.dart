import 'dart:io';

import 'package:dio/dio.dart';

enum profileType {
  product(name: 'product'),
  store(name: 'store'),
  advertisement(name: 'advertisement');

  const profileType({required this.name});

  final String name;
}

class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;
  String? dateOfBirth;
  bool? alertFollow;
  bool? location;
  File? imageFile;
  int? followers;
  int? followings;
  bool? verified;
  bool? isFollowing;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.dateOfBirth,
    this.alertFollow,
    this.location,
    this.imageFile,
    this.followers,
    this.verified,
    this.isFollowing,
    this.followings,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    verified = json['verified'];
    email = json['email'];
    image = json['image'];
    dateOfBirth = json['dob'];
    alertFollow = json['alert_follow'];
    location = json['location'];
    followers = (json['followers'] is List) ? 0 : json['followers'];
    followings = json['following'];
    isFollowing = json['is_following'];
  }

  FormData toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.dateOfBirth != null) data['dob'] = this.dateOfBirth;
    data['alert_follow'] = (this.alertFollow ?? false) ? 1 : 0;
    data['location'] = (this.location ?? false) ? 1 : 0;
    data['phone'] = this.phone;
    data['_method'] = "PUT";

    FormData formData = FormData.fromMap(data);
    if (this.imageFile != null) {
      formData.files.add(MapEntry(
        "image",
        MultipartFile.fromFileSync(
          this.imageFile!.path,
          filename: this.imageFile!.path.split('/').last,
        ),
      ));
    }

    return formData;
  }
}
