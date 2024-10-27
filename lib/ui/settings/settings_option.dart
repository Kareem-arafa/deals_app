import 'package:dealz/ui/settings/text_scale.dart';
import 'package:flutter/material.dart';

class SettingsOptions {
  SettingsOptions({
    required this.theme,
    this.textScaleFactor,
    this.textDirection = TextDirection.ltr,
    this.platform,
    this.languageLocale,
  });

  final ThemeData theme;
  final AppTextScaleValue? textScaleFactor;
  final TextDirection? textDirection;
  final TargetPlatform? platform;
  final Locale? languageLocale;

  SettingsOptions copyWith({
    ThemeData? theme,
    AppTextScaleValue? textScaleFactor,
    TextDirection? textDirection,
    TargetPlatform? platform,
    Locale? languageLocale,
  }) {
    return new SettingsOptions(
      theme: theme ?? this.theme,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      textDirection: textDirection ?? this.textDirection,
      platform: platform ?? this.platform,
      languageLocale: languageLocale ?? this.languageLocale,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final SettingsOptions typedOther = other;
    return theme == typedOther.theme &&
        textScaleFactor == typedOther.textScaleFactor &&
        textDirection == typedOther.textDirection &&
        platform == typedOther.platform;
  }

  @override
  String toString() {
    return '$runtimeType($theme)';
  }
}
