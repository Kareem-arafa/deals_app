import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/ads_screen.dart';
import 'package:dealz/ui/ads/commercial_ads_screen.dart';
import 'package:flutter/material.dart';

class MainAdsScreen extends StatefulWidget {
  const MainAdsScreen({super.key});

  @override
  State<MainAdsScreen> createState() => _MainAdsScreenState();
}

class _MainAdsScreenState extends State<MainAdsScreen> {
  List<Widget> ads = [
    AdsScreen(),
    CommercialAdsScreen(),
  ];
  int selectedBody = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: false,
            title: Text(
              Translations.of(context).text("AdvertisementsScreenTitle"),
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xffe7e7e7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TabBar(
                    splashBorderRadius: BorderRadius.circular(10),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'Almarai',
                    ),
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: (index) {
                      setState(() {
                        selectedBody = index;
                      });
                    },
                    tabs: [
                      Tab(
                        text: Translations.of(context).text("AdvertisementsScreenTitle"),
                      ),
                      Tab(
                        text: Translations.of(context).text("AdvertisementsScreenCommercialAdsTitle"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: ads[selectedBody]),
    );
  }
}
