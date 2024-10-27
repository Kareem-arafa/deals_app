import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/create_ads/add_car_for_sale.dart';
import 'package:dealz/ui/ads/create_ads/add_ordinary_ads.dart';
import 'package:dealz/ui/ads/create_ads/commericial_ad.dart';
import 'package:dealz/ui/ads/create_ads/create_store.dart';
import 'package:dealz/ui/ads/create_ads/trend_add.dart';
import 'package:flutter/material.dart';

class MainCreateAdScreen extends StatefulWidget {
  const MainCreateAdScreen({super.key});

  @override
  State<MainCreateAdScreen> createState() => _MainCreateAdScreenState();
}

class _MainCreateAdScreenState extends State<MainCreateAdScreen> {
  List<String> titles = [];

  List<String> images = [
    Assets.images.folder.path,
    Assets.images.bag.path,
    Assets.images.trendBag.path,
    Assets.images.bag.path,
  ];
  int selectedIndex = 0;
  List<Widget> body = [
    AddOrdinaryAds(),
    CreateStore(),
    TrendAdd(),
    CommercialAd(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    titles = [
      Translations.of(context).text("CreateAdsOrdinaryAdsTitle"),
      Translations.of(context).text("CreateAdsNewStoreTitle"),
      Translations.of(context).text("CreateAdsTrendAdsTitle"),
      Translations.of(context).text("CreateAdsCommercialTitle"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            Assets.images.backArrow.path,
            height: 18,
            matchTextDirection: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    Assets.images.logo.path,
                    height: 52,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Translations.of(context).text('CreateAdsTitle'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView.separated(
                      itemCount: titles.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsetsDirectional.only(start: 16, end: 16),
                      itemBuilder: (_, int index) {
                        return InkWell(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 90,
                                width: 105,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: selectedIndex == index ? Theme.of(context).primaryColor : Color(0xff126a8e),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        images[index],
                                        height: 25,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      new Text(
                                        titles[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned.directional(
                                textDirection: Directionality.of(context),
                                end: 10,
                                top: 10,
                                child: new Container(
                                  width: 20,
                                  height: 20,
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.asset(
                                      Assets.images.check.path,
                                      color: selectedIndex == index ? null : Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(
                        width: 8,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: body[selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
