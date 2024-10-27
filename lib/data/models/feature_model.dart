class FeatureModel {
  int? id;
  int? sectionId;
  String? arName;
  String? enName;
  String? image;

  FeatureModel({this.id, this.sectionId, this.arName, this.enName, this.image});

  FeatureModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    arName = json['ar_name'];
    enName = json['en_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['section_id'] = this.sectionId;
    data['ar_name'] = this.arName;
    data['en_name'] = this.enName;
    data['image'] = this.image;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeatureModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          sectionId == other.sectionId &&
          arName == other.arName &&
          enName == other.enName &&
          image == other.image;

  @override
  int get hashCode => id.hashCode ^ sectionId.hashCode ^ arName.hashCode ^ enName.hashCode ^ image.hashCode;

  String name(String locale) {
    if (locale == "ar") {
      return arName ?? "";
    } else {
      return enName ?? "";
    }
  }


}
