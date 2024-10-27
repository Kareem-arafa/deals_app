extension StringExtention on String {
  bool get isEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  bool get isPhone => RegExp(r'^01(0|1|2|5){1}[0-9]{8}$').hasMatch(this);
  bool get isPassword => RegExp(r'^(?!.*?\d{5}).+$').hasMatch(this);
  bool get isArabic =>
      RegExp(r'[\u0621-\u064A]+', unicode: true).hasMatch(this);
}
