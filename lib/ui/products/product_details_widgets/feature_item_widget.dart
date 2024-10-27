import 'package:flutter/material.dart';

class FeatureItemWidget extends StatelessWidget {
  final String img;
  final String title;
  const FeatureItemWidget({super.key, required this.img, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              img,
              height: 16,
            ),
            SizedBox(
              height: 8,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: new Text(title,
                  style: TextStyle(
                    color: Color(0xff171717),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
