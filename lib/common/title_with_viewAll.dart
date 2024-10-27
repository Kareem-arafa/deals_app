import 'package:dealz/translate/translations.dart';
import 'package:flutter/material.dart';

class TitleWithViewAll extends StatelessWidget {
  final String? title;
  final Function()? onTap;

  const TitleWithViewAll({
    super.key,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (onTap != null)
          InkWell(
            onTap: onTap,
            child: Text(
              Translations.of(context).text("homeScreenTitleViewAllLabel"),
              style: TextStyle(
                color: Color(0xff7a7a7a),
              ),
            ),
          ),
      ],
    );
  }
}
