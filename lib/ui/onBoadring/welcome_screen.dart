import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealz/common/custom_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/login_screen.dart';
import 'package:dealz/ui/onBoadring/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentPage = 0;
  CarouselController carouselController = CarouselController();
  late List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      Image.asset(Assets.images.welcome.path),
      Image.asset(Assets.images.welcome.path),
      Image.asset(Assets.images.welcome.path)
    ];
    super.initState();
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
        bottom: false,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CarouselSlider(
                items: _buildImages(_pages),
                carouselController: carouselController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height - 150,
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: AnimatedSmoothIndicator(
                          activeIndex: _currentPage,
                          count: _pages.length,
                          effect: CustomizableEffect(
                            spacing: 8,
                            activeDotDecoration: DotDecoration(
                              color: Theme.of(context).primaryColor,
                              height: 2,
                              width: 35,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            dotDecoration: DotDecoration(
                              color: Color(0xffe8e8e8),
                              height: 2,
                              width: 35,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        Translations.of(context).text("welcomeScreenTitle"),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        Translations.of(context).text("welcomeScreenSubTitle"),
                        style: TextStyle(
                          color: Color(0xff8b8b8b),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonWidget(
                              type: ButtonType.secondary,
                              title: Translations.of(context).text("welcomeScreenSkipButtonTitle"),
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LoginScreen(),
                                    ),
                                    (_) => false);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: ButtonWidget(
                              type: ButtonType.primary,
                              title: Translations.of(context).text("welcomeScreenNextButtonTitle"),
                              onTap: () {
                                if (_currentPage == 2) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => OnBoardingScreen(),
                                      ),
                                      (route) => false);
                                } else {
                                  carouselController.nextPage();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
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
