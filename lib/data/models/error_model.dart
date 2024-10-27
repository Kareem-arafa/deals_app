class ErrorModel {
  List<String>? name;
  List<String>? phone;
  List<String>? email;
  List<String>? whatsapp;
  List<String>? image;
  List<String>? instagram;
  List<String>? facebook;
  List<String>? tiktok;
  List<String>? snapchat;
  List<String>? youtube;
  List<String>? commercialRecord;
  List<String>? closingTime;
  List<String>? openingTime;
  String? errorMessages;

  ErrorModel({
    this.name,
    this.phone,
    this.email,
    this.errorMessages,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    name = json['name']?.cast<String>();
    phone = json['phone']?.cast<String>();
    email = json['email']?.cast<String>();
    whatsapp = json['whatsapp']?.cast<String>();
    image = json['image']?.cast<String>();
    instagram = json['instagram']?.cast<String>();
    facebook = json['facebook']?.cast<String>();
    tiktok = json['tiktok']?.cast<String>();
    snapchat = json['snapchat']?.cast<String>();
    youtube = json['youtube']?.cast<String>();
    commercialRecord = json['commercial_record']?.cast<String>();
    closingTime = json['closing_time']?.cast<String>();
    openingTime = json['opening_time']?.cast<String>();
    errorMessages = json['message'];
  }

  String get errorMessage {
    String message;
    if (name != null) {
      message = name?.first ?? 'حدث خطأ ما';
    } else if (phone != null) {
      message = phone?.first ?? 'حدث خطأ ما';
    } else if (email != null) {
      message = email?.first ?? 'حدث خطأ ما';
    } else if (whatsapp != null) {
      message = whatsapp?.first ?? 'حدث خطأ ما';
    } else if (image != null) {
      message = image?.first ?? 'حدث خطأ ما';
    } else if (instagram != null) {
      message = instagram?.first ?? 'حدث خطأ ما';
    } else if (snapchat != null) {
      message = snapchat?.first ?? 'حدث خطأ ما';
    } else if (tiktok != null) {
      message = tiktok?.first ?? 'حدث خطأ ما';
    } else if (facebook != null) {
      message = facebook?.first ?? 'حدث خطأ ما';
    } else if (youtube != null) {
      message = youtube?.first ?? 'حدث خطأ ما';
    } else if (commercialRecord != null) {
      message = commercialRecord?.first ?? 'حدث خطأ ما';
    } else if (closingTime != null) {
      message = closingTime?.first ?? 'حدث خطأ ما';
    } else if (openingTime != null) {
      message = openingTime?.first ?? 'حدث خطأ ما';
    } else if (errorMessages != null) {
      message = errorMessages ?? 'حدث خطأ ما';
    } else {
      message = 'حدث خطأ ما';
    }
    return message;
  }
}
