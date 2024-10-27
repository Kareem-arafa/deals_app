class SocialMediaModel {
  int? id;
  String? type;
  String? link;

  SocialMediaModel({this.id, this.type, this.link});

  SocialMediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['link'] = this.link;
    return data;
  }
}
