import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/image_viewer.dart';
import 'package:dealz/ui/products/product_details_widgets/add_comment_widget.dart';
import 'package:dealz/ui/products/product_details_widgets/comment_list.dart';
import 'package:dealz/ui/products/product_details_widgets/favorite_icon.dart';
import 'package:dealz/ui/products/rating_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'product_details_widgets/report_ads_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final HomeProduct product;

  ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _current = 0;
  double rate = 0;

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          widget.product.getName(Translations.of(context).currentLanguage),
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
        actions: [
          // if (widget.viewModel.user != null)
          FavoriteIcon(
            product: MyAdsModel(),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewer(imageUrl: widget.product.image!),
                    ),
                  );
                },
                child: CarouselSlider(
                  items: _buildImages([IamgeModel(image: widget.product.image!)]),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
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
              ),
              SizedBox(
                height: 18,
              ),
              Center(
                child: Text(
                  widget.product.getName(Translations.of(context).currentLanguage),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                      widget.product.price == null
                          ? SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.price?.toString() ?? "0.0",
                                      style: TextStyle(
                                        color: ((widget.product.discount ?? 0) > 0)
                                            ? Colors.black
                                            : Theme.of(context).primaryColor,
                                        fontSize: 14,
                                        decoration:
                                            ((widget.product.discount ?? 0) > 0) ? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "KWD",
                                      style: TextStyle(
                                        color: ((widget.product.discount ?? 0) > 0)
                                            ? Colors.black
                                            : Theme.of(context).primaryColor,
                                        fontSize: 14,
                                        decoration:
                                            ((widget.product.discount ?? 0) > 0) ? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                  ],
                                ),
                                if ((widget.product.discount ?? 0) > 0)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.product.priceAfterDiscount?.toString() ?? "0.0",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "KWD",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
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
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${widget.product.createdAt?.day ?? 1} ",
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                color: Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: DateFormat("MMMM").format(widget.product.createdAt ?? DateTime.now()),
                              style: TextStyle(
                                fontFamily: 'Almarai',
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
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${widget.product.views ?? 0} ",
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                color: Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: Translations.of(context).text("storeDetailsScreenViewsLabel"),
                              style: TextStyle(
                                fontFamily: 'Almarai',
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
                height: 25,
              ),
              InkWell(
                onTap: () {
                  // if (this.widget.viewModel.user != null)
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RatingDialog(
                        contentId: widget.product.id!,
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translations.of(context).text("storeDetailsScreenRatingLabel"),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.product.rating?.votes ?? 0} ${Translations.of(context).text("storeDetailsScreenVotesLabel")}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        IgnorePointer(
                          ignoring: true,
                          child: RatingBar.builder(
                            initialRating: widget.product.rating?.stars?.toDouble() ?? 0,
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                Translations.of(context).text("storeDetailsScreenDescriptionLabel"),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.product.getDescription(Translations.of(context).currentLanguage),
                style: TextStyle(
                  color: Color(0xff858585),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Translations.of(context).text("adsDetailsComments"),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),*/
              /*SizedBox(
                height: 15,
              ),
              CommentList(
                myAdsModel: widget.p,
                currentUser: widget.viewModel.user,
              ),
              SizedBox(
                height: 30,
              ),
              AddCommentWidget(
                adsModel: widget.adsModel,
              ),*/
              SizedBox(
                height: 30,
              ),
              /* Row(
                children: [
                  Text(
                    Translations.of(context).text("similarAdsLabel"),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),*/
              /*SizedBox(
                height: 20,
              ),
              this.widget.viewModel.getSimilarAdsReport.status == ActionStatus.running
                  ? Center(
                child: CupertinoActivityIndicator(
                  animating: true, // Control animation
                  color: Theme.of(context).primaryColor,
                ),
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: AdsWidget(
                  ads: this.widget.viewModel.similarAds,
                  isSimilar: true,
                ),
              ),*/
              if (widget.product.price == null)
                Center(
                  child: Text(
                    Translations.of(context).text("productPriceNote"),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.red[300],
                    ),
                  ),
                ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.grey.withOpacity(.5),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Translations.of(context).text("adsNumLabel")}${widget.product.id}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
                      ),
                      ReportAdsWidget(
                        adsId: widget.product.id!,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: Colors.grey.withOpacity(.5),
                    ),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.grey),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.product.store?.logo ?? ""),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${Translations.of(context).text("adsDetailsAddByLabel")} : ',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: widget.product.store?.name ?? "",
                              style: TextStyle(
                                color: Color(0xff2d2d2d),
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        launch("tel://${widget.product.store!.phone}");
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.images.phone.path,
                              height: 20,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              Translations.of(context).text("commercialStoreDetailsCall"),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        whatsapp(widget.product.store!.whatsapp ?? "");
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff07be83),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Image.asset(
                            Assets.images.whatsapp.path,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  whatsapp(String phone) async {
    var androidUrl = "whatsapp://send?phone=$phone";
    var iosUrl = "https://wa.me/$phone";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      showToast('WhatsApp is not installed.');
    }
  }

  _buildImages(List<IamgeModel> images) {
    List<Widget> services = images
        .map(
          (e) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(e.image ?? ""),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
        .toList();
    return services;
  }
}
