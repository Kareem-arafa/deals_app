import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/trend/store_item.dart';
import 'package:flutter/material.dart';

class StoresWidget extends StatefulWidget {
  const StoresWidget({super.key});

  @override
  State<StoresWidget> createState() => _StoresWidgetState();
}

class _StoresWidgetState extends State<StoresWidget> {
  List<String> products = [
    Assets.images.car.path,
    Assets.images.car.path,
    Assets.images.car.path,
    Assets.images.car.path,
    Assets.images.car.path,
    Assets.images.car.path,
    Assets.images.car.path,
    Assets.images.car.path,
    Assets.images.car.path,
    Assets.images.car.path,
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: products
            .map(
              (e) => Padding(
                padding: EdgeInsetsDirectional.only(start: 10),
                child: StoreItem(),
              ),
            )
            .toList(),
      ),
    );
  }
}
