import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealz/common/custom_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/login_screen.dart';
import 'package:dealz/ui/onBoadring/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  CarouselController carouselController = CarouselController();
  late List<Widget> _pages;

  @override
  void didChangeDependencies() {
    _pages = [
      OnBoardingItem(
        image: Assets.images.onboarding1.path,
        title: Translations.of(context).text('onBoardingScreenPage1Message'),
      ),
      OnBoardingItem(
        image: Assets.images.onboarding2.path,
        title: Translations.of(context).text('onBoardingScreenPage1Message'),
      ),
      OnBoardingItem(
        image: Assets.images.onboarding3.path,
        title: Translations.of(context).text('onBoardingScreenPage1Message'),
      ),
    ];

    super.didChangeDependencies();
  }

  void onPageChanged(index, reason) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                      (_) => false);
                },
                child: Text(
                  Translations.of(context).text('welcomeScreenSkipButtonTitle'),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CarouselSlider(
              items: _buildImages(_pages),
              carouselController: carouselController,
              options: CarouselOptions(
                height: 470,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: onPageChanged,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: AnimatedSmoothIndicator(
                activeIndex: _currentPage,
                count: _pages.length,
                effect: CustomizableEffect(
                  spacing: 4,
                  activeDotDecoration: DotDecoration(
                    color: Theme.of(context).primaryColor,
                    height: 5,
                    width: 18,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  dotDecoration: DotDecoration(
                    color: Color(0xffe8e8e8),
                    height: 5,
                    width: 12,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ButtonWidget(
                type: ButtonType.primary,
                title: Translations.of(context).text('welcomeScreenNextButtonTitle'),
                onTap: () {
                  if (_currentPage == 2) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                        (_) => false);
                  } else {
                    carouselController.nextPage();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildImages(List<Widget> images) {
    List<Widget> slider = images.map((e) => e).toList();
    return slider;
  }
}
