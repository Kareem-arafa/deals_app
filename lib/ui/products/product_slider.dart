import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({super.key});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  int _current = 0;

  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<String> productSlider = [
    Assets.images.car.path,
    Assets.images.car.path,
    Assets.images.car.path,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: _buildImages(productSlider),
          options: CarouselOptions(
            height: 225,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: productSlider.length > 1 ? true : false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 2),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          alignment: Alignment.center,
          child: AnimatedSmoothIndicator(
            activeIndex: _current,
            count: productSlider.length,
            effect: CustomizableEffect(
              spacing: 6,
              activeDotDecoration: DotDecoration(
                color: Theme.of(context).primaryColor,
                height: 10,
                width: 10,
                borderRadius: BorderRadius.circular(50),
              ),
              dotDecoration: DotDecoration(
                  color: Color(0xffd9d9d9),
                  height: 8,
                  width: 8,
                  borderRadius: BorderRadius.circular(100),
                  dotBorder: DotBorder(
                    color: Color(0xff979797),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  _buildImages(List<String> images) {
    List<Widget> services = images
        .map(
          (e) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(e),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
        .toList();
    return services;
  }
}
