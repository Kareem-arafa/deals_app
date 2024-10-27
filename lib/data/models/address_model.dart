class AddressModel {
  int? id;
  int? userId;
  int? countryId;
  int? cityId;
  String? addressName;
  String? addressLine1;
  String? addressLine2;
  String? phone;
  String? postalCode;
  String? notes;
  String? createdAt;
  String? updatedAt;

  AddressModel({
    this.id,
    this.userId,
    this.countryId,
    this.cityId,
    this.addressName,
    this.addressLine1,
    this.addressLine2,
    this.phone,
    this.postalCode,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    addressName = json['address_name'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    phone = json['phone'];
    postalCode = json['postal_code'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['address_name'] = this.addressName;
    data['address_line_1'] = this.addressLine1;
    data['phone'] = this.phone;
    return data;
  }
}
