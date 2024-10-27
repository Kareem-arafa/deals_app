import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget? child;
  final double? height;
  CustomBottomSheet({Key? key, this.child, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        color: Color(0xfff4f4f4),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10,
            ),
            child!
          ],
        ),
      ),
    );
  }
}
