import 'package:dealz/data/models/commercial_ad_model.dart';
import 'package:flutter/material.dart';

import 'commercial_ads_by_id.dart';

class CommercialAdsPagerScreen extends StatefulWidget {
  final List<CommercialAdsModel> ads;
  final CommercialAdsModel initialAds;

  const CommercialAdsPagerScreen({super.key, required this.ads, required this.initialAds});

  @override
  _CommercialAdsPagerScreenState createState() => _CommercialAdsPagerScreenState();
}

class _CommercialAdsPagerScreenState extends State<CommercialAdsPagerScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.ads.indexOf(widget.initialAds));
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.ads.length,
              onPageChanged: (int page) {},
              itemBuilder: (BuildContext context, int index) {
                return CommercialAdsByIdScreen(
                  adsId: widget.ads[index].id!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
