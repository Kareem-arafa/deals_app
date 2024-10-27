import 'package:flutter/foundation.dart';
import 'dart:async';

extension DurationExtentions on Duration {
  String printMMSS() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

extension IntExtentions on int {
  Duration seconds() => Duration(seconds: this);
}

class Debouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}
