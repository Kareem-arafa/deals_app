class DaysModel {
  final String? arabicName;
  final String? englishName;

  DaysModel({
    this.arabicName,
    this.englishName,
  });

  String name(String lang) {
    if (lang == 'ar') {
      return arabicName ?? '';
    } else {
      return englishName ?? '';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DaysModel &&
          runtimeType == other.runtimeType &&
          arabicName == other.arabicName &&
          englishName == other.englishName;

  @override
  int get hashCode => arabicName.hashCode ^ englishName.hashCode;
}

List<DaysModel> days = [
  DaysModel(arabicName: 'السبت', englishName: 'saturday'),
  DaysModel(arabicName: 'الأحد', englishName: 'sunday'),
  DaysModel(arabicName: 'الإثنين', englishName: 'monday'),
  DaysModel(arabicName: 'الثلاثاء', englishName: 'tuesday'),
  DaysModel(arabicName: 'الأربعاء', englishName: 'wednesday'),
  DaysModel(arabicName: 'الخميس', englishName: 'thursday'),
  DaysModel(arabicName: 'الجمعة', englishName: 'friday'),
];

class LanguageModel {
  final String? arabicName;
  final String? englishName;
  final String? code;

  LanguageModel({
    this.arabicName,
    this.englishName,
    this.code,
  });

  String name(String lang) {
    if (lang == 'ar') {
      return arabicName ?? '';
    } else {
      return englishName ?? '';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModel &&
          runtimeType == other.runtimeType &&
          arabicName == other.arabicName &&
          englishName == other.englishName &&
          code == other.code;

  @override
  int get hashCode => arabicName.hashCode ^ englishName.hashCode ^ code.hashCode;
}

List<LanguageModel> appLanguages = [
  LanguageModel(arabicName: 'العربية', englishName: 'العربية',code: 'ar'),
  LanguageModel(arabicName: 'English', englishName: 'English',code: 'en'),
];