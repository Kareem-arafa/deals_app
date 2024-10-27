import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/translate/translations.dart';
import 'package:flutter/material.dart';

class AdsItemWidget extends StatelessWidget {
  final MyAdsModel ads;
  final bool isSimilar;

  const AdsItemWidget({super.key, required this.ads, this.isSimilar = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Color(0x7fdadada),
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ads.images?.isNotEmpty ?? false
                  ? Container(
                      height: 110,
                      width: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              isSimilar ? ads.images?.first.imageUrl ?? "" : ads.images?.first.image ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      height: 110,
                      width: 135,
                    ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Camry in kwait",
                style: TextStyle(
                  color: Color(0xffadadad),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                ads.getTitle(Translations.of(context).currentLanguage),
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              if (ads.price != null)
                Text(
                  "${ads.price} KWD",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              SizedBox(
                height: 6,
              ),
              /*  Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  "${product.days ?? 0} ${Translations.of(context).text("homeScreenProductItemDaysLabel")}",
                  style: TextStyle(
                    color: Color(0xffadadad),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
