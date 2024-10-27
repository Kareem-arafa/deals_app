class CityModel {
  int? id;
  int? countryId;
  String? arName;
  String? enName;
  int? delivery;
  String? active;
  String? createdAt;
  String? updatedAt;
  int? stateId;

  CityModel({
    this.id,
    this.countryId,
    this.arName,
    this.enName,
    this.delivery,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.stateId,
  });

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    arName = json['ar_name'];
    enName = json['en_name'];
    delivery = json['delivery'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stateId = json['state_id'];
  }

  String name(String locale) {
    if (locale == 'ar') {
      return arName ?? '';
    } else {
      return enName ?? '';
    }
  }
}
