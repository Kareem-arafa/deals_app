class SectionAttributesModel {
  int? id;
  String? name;
  String? type;
  bool? hasRange;
  String? unit;
  List<Options>? options;

  SectionAttributesModel({
    this.id,
    this.name,
    this.type,
    this.hasRange,
    this.unit,
    this.options,
  });

  SectionAttributesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    hasRange = json['has_range'];
    unit = json['unit'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }
}

class Options {
  int? id;
  String? optionName;

  Options({
    this.id,
    this.optionName,
  });

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionName = json['name'];
  }

  String name(String local) {
    return optionName ?? "";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Options && runtimeType == other.runtimeType && id == other.id && optionName == other.optionName;

  @override
  int get hashCode => id.hashCode ^ optionName.hashCode;

  @override
  String toString() {
    return 'Options{id: $id, optionName: $optionName}';
  }
}
