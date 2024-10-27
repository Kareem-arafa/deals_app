import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealz/data/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AdsSlider extends StatefulWidget {
  final bool? hasTitle;
  final List<Sliders> sliders;
  final double height;

  const AdsSlider({super.key, this.hasTitle, required this.sliders, this.height = 160});

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: _buildImages(widget.sliders.map((e) => e.image ?? '').toList()),
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: widget.sliders.length > 1 ? true : false,
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
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          child: AnimatedSmoothIndicator(
            activeIndex: _current,
            count: widget.sliders.length,
            effect: CustomizableEffect(
              spacing: 6,
              activeDotDecoration: DotDecoration(
                color: Theme.of(context).primaryColor,
                height: 4,
                width: 18,
                borderRadius: BorderRadius.circular(50),
              ),
              dotDecoration: DotDecoration(
                color: Color(0xffd9d9d9),
                height: 4,
                width: 18,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildImages(List<String> images) {
    List<Widget> services = images
        .map(
          (e) => Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(e),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (widget.hasTitle ?? false)
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0x59000000),
                  ),
                ),
              if (widget.hasTitle ?? false)
                Positioned(
                  left: 20,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        "Cairo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      new Text(
                        "Product Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        )
        .toList();
    return services;
  }
}
