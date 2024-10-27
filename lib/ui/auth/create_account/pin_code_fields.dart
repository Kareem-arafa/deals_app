import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeFields extends StatefulWidget {
  final Function(String) onCompleted;

  const PinCodeFields({super.key, required this.onCompleted});

  @override
  State<PinCodeFields> createState() => _PinCodeFeildsState();
}

class _PinCodeFeildsState extends State<PinCodeFields> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        autoFocus: true,
        appContext: context,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        pastedTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          selectedColor: Color(0xff979797).withOpacity(0.3),
          selectedFillColor: Colors.transparent,
          shape: PinCodeFieldShape.underline,
          errorBorderColor: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(30),
          borderWidth: 2,
          activeFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
          inactiveColor: Color(0xff979797).withOpacity(0.3),
          activeColor: Theme.of(context).primaryColor,
          disabledColor: Colors.transparent,
        ),
        cursorColor: Theme.of(context).primaryColor,
        animationDuration: Duration(milliseconds: 100),
        textStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        beforeTextPaste: (text) {
          return true;
        },
        onChanged: (value) {
          print(value);
        },
        onCompleted: widget.onCompleted,
      ),
    );
  }
}
