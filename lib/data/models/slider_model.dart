class SliderModel {
  int? id;
  String? arName;
  String? enName;
  String? arDesc;
  String? enDesc;
  String? image;
  int? sort;
  String? active;
  String? link;
  String? type;

  SliderModel(
      {this.id,
        this.arName,
        this.enName,
        this.arDesc,
        this.enDesc,
        this.image,
        this.sort,
        this.active,
        this.link,
        this.type});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arName = json['ar_name'];
    enName = json['en_name'];
    arDesc = json['ar_desc'];
    enDesc = json['en_desc'];
    image = json['image'];
    sort = json['sort'];
    active = json['active'];
    link = json['link'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ar_name'] = this.arName;
    data['en_name'] = this.enName;
    data['ar_desc'] = this.arDesc;
    data['en_desc'] = this.enDesc;
    data['image'] = this.image;
    data['sort'] = this.sort;
    data['active'] = this.active;
    data['link'] = this.link;
    data['type'] = this.type;
    return data;
  }
}