class StateModel {
  int? id;
  int? countryId;
  String? enName;
  String? arName;
  int? active;
  String? createdAt;
  String? updatedAt;

  StateModel({
    this.id,
    this.countryId,
    this.enName,
    this.arName,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  String name(String locale) {
    if (locale == 'ar') {
      return arName ?? '';
    } else {
      return enName ?? '';
    }
  }
}
