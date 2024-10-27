import 'package:dealz/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SubcategoryItem extends StatelessWidget {
  final bool? isSelected;
  const SubcategoryItem({super.key, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ?? false
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset(
          Assets.images.mercedes.path,
          height: 70,
        ),
      ),
    );
  }
}
