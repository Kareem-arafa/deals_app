class DealsSectionModel {
  int? id;
  String? arName;
  String? enName;
  String? image;
  int? sort;
  String? active;
  String? sectionType;
  String? createdAt;
  String? updatedAt;

  DealsSectionModel(
      {this.id,
        this.arName,
        this.enName,
        this.image,
        this.sort,
        this.active,
        this.sectionType,
        this.createdAt,
        this.updatedAt});

  DealsSectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arName = json['ar_name'];
    enName = json['en_name'];
    image = json['image'];
    sort = json['sort'];
    active = json['active'];
    sectionType = json['section_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ar_name'] = this.arName;
    data['en_name'] = this.enName;
    data['image'] = this.image;
    data['sort'] = this.sort;
    data['active'] = this.active;
    data['section_type'] = this.sectionType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  String name(String locale) {
    if (locale == 'ar') {
      return arName ?? '';
    } else {
      return enName ?? '';
    }
  }
}
