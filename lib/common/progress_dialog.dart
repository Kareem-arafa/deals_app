import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

String _dialogMessage = "Loading...";

enum ProgressDialogType { circle, bar }

ProgressDialogType _progressDialogType = ProgressDialogType.circle;
double _progress = 0.0;

class ProgressDialog {
  _MyDialog? _dialog;
  bool? _isShowing = false;
  BuildContext? _buildContext, _context;

  ProgressDialog(BuildContext buildContext, {ProgressDialogType type = ProgressDialogType.circle}) {
    _buildContext = buildContext;

    _progressDialogType = type;
  }

  void setMessage(String mess) {
    _dialogMessage = mess;
  }

  void update({double? progress, String? message}) {
    if (_progressDialogType == ProgressDialogType.bar) _progress = progress!;
    _dialogMessage = message!;
  }

  bool isShowing() {
    return _isShowing!;
  }

  void hide() {
    _isShowing = false;
    Navigator.of(_context!).pop();
  }

  void show() {
    _dialog = new _MyDialog();
    _isShowing = true;
    showDialog<dynamic>(
      context: _buildContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _context = context;
        return Dialog(
          insetPadding: EdgeInsets.zero,
          insetAnimationCurve: Curves.easeInOut,
          insetAnimationDuration: Duration(milliseconds: 100),
          elevation: 0.0,
          backgroundColor: Colors.white12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: _dialog,
        );
      },
    );
  }
}

class _MyDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyDialogState();
  }
}

class _MyDialogState extends State<_MyDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Center(
        child: CupertinoActivityIndicator(
          animating: true, // Control animation
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
