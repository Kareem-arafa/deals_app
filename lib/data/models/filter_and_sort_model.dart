import 'package:collection/collection.dart';
enum sortType { high, low }

class SortAndFilterModel {
  sortType? sortName;
  sortType? sortPrice;
  int? categoryId;
  int? lowPrice;
  int? highPrice;
  int? cityId;
  List<AttributeFilterData>? attributeFilter;

  SortAndFilterModel({
    this.sortName,
    this.sortPrice,
    this.categoryId,
    this.lowPrice,
    this.highPrice,
    this.cityId,
    this.attributeFilter,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (categoryId != null) {
      data['category'] = categoryId;
    }
    if (cityId != null) {
      data['location[city]'] = cityId;
    }
    if (sortName != null) {
      data['sort[name]'] = sortName!.name;
    }
    if (sortPrice != null) {
      data['sort[price]'] = sortPrice!.name;
    }
    if (lowPrice != null && highPrice != null) {
      data['price[low]'] = lowPrice;
      data['price[high]'] = highPrice;
    }
    if ((attributeFilter?.isNotEmpty ?? false)) {
      attributeFilter!.forEach((element) {
        data.addAll(element.toJson());
      });
    }
    return data;
  }

  SortAndFilterModel copyWith({
    sortType? sortName,
    sortType? sortPrice,
    int? categoryId,
    int? lowPrice,
    int? highPrice,
    int? cityId,
    List<AttributeFilterData>? attributeFilter,
  }) {
    return SortAndFilterModel(
      sortName: sortName ?? this.sortName,
      sortPrice: sortPrice ?? this.sortPrice,
      cityId: cityId ?? this.cityId,
      categoryId: categoryId ?? this.categoryId,
      lowPrice: lowPrice ?? this.lowPrice,
      highPrice: highPrice ?? this.highPrice,
      attributeFilter: attributeFilter ?? this.attributeFilter,
    );
  }
}

class AttributeFilterData {
  int attributeId;
  List<dynamic> attributeValue;
  List<dynamic> attributeValueId;
  var attributeValueHigh;
  var attributeValueLow;
  bool hasRange;

  AttributeFilterData({
    required this.attributeValue,
    required this.attributeValueId,
    required this.attributeId,
    required this.hasRange,
    this.attributeValueHigh,
    this.attributeValueLow,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (hasRange) {
      data['attributes[$attributeId][low]'] = attributeValueLow;
      data['attributes[$attributeId][high]'] = attributeValueHigh;
    } else {
      attributeValueId.forEachIndexed((index,element) {
        data['attributes[$attributeId][$index]'] = element;
      });
    }
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributeFilterData && runtimeType == other.runtimeType && attributeId == other.attributeId;

  @override
  int get hashCode => attributeId.hashCode;

  AttributeFilterData copyWith({
    int? attributeId,
    List<dynamic>? attributeValue,
    List<dynamic>? attributeValueId,
    var attributeValueHigh,
    var attributeValueLow,
    bool? hasRange,
  }) {
    return AttributeFilterData(
      attributeValue: attributeValue ?? this.attributeValue,
      attributeValueId: attributeValueId ?? this.attributeValueId,
      attributeId: attributeId ?? this.attributeId,
      hasRange: hasRange ?? this.hasRange,
      attributeValueHigh: attributeValueHigh ?? this.attributeValueHigh,
      attributeValueLow: attributeValueLow ?? this.attributeValueLow,
    );
  }
}
