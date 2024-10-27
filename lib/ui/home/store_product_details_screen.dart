import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/title_with_viewAll.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/ads/ads_widget.dart';
import 'package:dealz/ui/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StoreProductDetailsScreen extends StatefulWidget {
  const StoreProductDetailsScreen({super.key});

  @override
  State<StoreProductDetailsScreen> createState() => _StoreProductDetailsScreenState();
}

class _StoreProductDetailsScreenState extends State<StoreProductDetailsScreen> {
  double rate = 0;
  int _current = 0;

  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<String> adsSlider = [
    Assets.images.airPods.path,
    Assets.images.airPods.path,
    Assets.images.airPods.path,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Product Screen',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            Assets.images.backArrow.path,
            height: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Image.asset(
              Assets.images.favoriteBlack.path,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            child: Image.asset(
              Assets.images.shareIcon.path,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: _buildImages(adsSlider),
                    options: CarouselOptions(
                      height: 235,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: adsSlider.length > 1 ? true : false,
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
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: AnimatedSmoothIndicator(
                      activeIndex: _current,
                      count: adsSlider.length,
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
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: new Text(
                      " commercial space for rent",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: new Text(
                            "1728 kwd",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: new Text(
                          "1729 kwd",
                          style: TextStyle(
                            color: Color(0xffeb3a45),
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: new TextSpan(
                              children: [
                                new TextSpan(
                                  text: "100 ",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                new TextSpan(
                                  text: "kwd",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 17,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff979797),
                                width: 0.6,
                              ),
                            ),
                          ),
                          RichText(
                            text: new TextSpan(
                              children: [
                                new TextSpan(
                                  text: "26 ",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                new TextSpan(
                                  text: "Jun",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 17,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff979797),
                                width: 0.6,
                              ),
                            ),
                          ),
                          RichText(
                            text: new TextSpan(
                              children: [
                                new TextSpan(
                                  text: "3990 ",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                new TextSpan(
                                  text: "Views",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Rating",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        children: [
                          new Text(
                            "200 Votes",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 16,
                            unratedColor: Color(0xff1c274c),
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                            onRatingUpdate: (rating) {
                              rate = rating;
                              setState(() {});
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Image.asset(
                                Assets.images.star.path,
                                color: Colors.amber,
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Product Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      new Text(
                        "View all",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  new Text(
                    "Some claim lorem ipsum threatens to promote design over content, while others defend its ",
                    style: TextStyle(
                      color: Color(0xff858585),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  new Text(
                    "Read More",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Comments",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      new Text(
                        "View all",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MediaQuery.removePadding(
                    context: context,
                    removeBottom: true,
                    removeTop: true,
                    child: ListView.separated(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Text(
                                  "Ahmed Ebrahim",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Image.asset(
                                  Assets.images.flagIcon.path,
                                  height: 15,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: new Text(
                                    "Some claim lorem ipsum threatens to promote design over content, while others defend its ",
                                    style: TextStyle(
                                      color: Color(0xff858585),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (index == 1)
                                  Row(
                                    children: [
                                      Image.asset(
                                        Assets.images.trash.path,
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset(
                                        Assets.images.editIcon.path,
                                        height: 15,
                                        color: Color(0xff858585),
                                      ),
                                    ],
                                  )
                              ],
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => Divider(
                        color: Color(0xff979797),
                        height: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: new Text(
                      "only 3units  left on storage",
                      style: TextStyle(
                        color: Color(0xffe42b2b),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    barRadius: Radius.circular(50),
                    padding: EdgeInsets.zero,
                    lineHeight: 10.0,
                    backgroundColor: Color(0xffdedede),
                    percent: 0.2,
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Color(0xffe64848),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      new Container(
                        width: 9,
                        height: 9,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      new Text(
                        "Free Delivery for order higher than 20 KWD",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      new Container(
                        width: 9,
                        height: 9,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      new Text(
                        "Free Delivery for order higher than 20 KWD",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ButtonWidget(
                    type: ButtonType.primary,
                    title: "Buy Now",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CartScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TitleWithViewAll(
                    title: "Suggestions",
                    onTap: () {},
                  ),
                ],
              ),
            ),
            AdsWidget(
              ads: [],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  detailsBoxes(String title, String img) {
    return Expanded(
      child: Container(
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
              Image.asset(
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
      ),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(e),
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                right: 15,
                child: Image.asset(
                  Assets.images.flagIcon.path,
                  height: 25,
                ),
              ),
            ],
          ),
        )
        .toList();
    return services;
  }
}
