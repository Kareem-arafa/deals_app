import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/ui/ads/ads_details_by_id_screen.dart';
import 'package:dealz/ui/ads/ads_item_widget.dart';
import 'package:dealz/ui/ads/ads_details_screen.dart';
import 'package:dealz/ui/products/product_item.dart';
import 'package:flutter/material.dart';

class AdsWidget extends StatefulWidget {
  final List<MyAdsModel> ads;
  final bool isSimilar;

  const AdsWidget({super.key, required this.ads, this.isSimilar = false});

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 224,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final MyAdsModel ads = widget.ads[index];
          return Padding(
            padding: EdgeInsetsDirectional.only(start: 10),
            child: InkWell(
              onTap: () {
                if (widget.isSimilar) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AdsDetailsByIdView(
                        adsId: ads.id!,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AdsDetailsByIdView(
                        adsId: ads.id!,
                      ),
                    ),
                  );
                }
              },
              child: AdsItemWidget(
                ads: ads,
                isSimilar: widget.isSimilar,
              ),
            ),
          );
        },
        itemCount: widget.ads.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
