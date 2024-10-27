import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/home/store_work_time_dialog.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreDetailsScreen extends StatelessWidget {
  final Stores? store;
  final HomeType homeType;
  final int? storeId;

  const StoreDetailsScreen({super.key, this.store, required this.homeType, this.storeId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _StoreDetailsScreenContent(
        viewModel: viewModel,
        store: store,
        homeType: homeType,
        storeId: storeId,
      ),
    );
  }
}

class _StoreDetailsScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final Stores? store;
  final HomeType homeType;
  final int? storeId;

  const _StoreDetailsScreenContent({
    required this.viewModel,
    this.store,
    required this.homeType,
    this.storeId,
  });

  @override
  State<_StoreDetailsScreenContent> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<_StoreDetailsScreenContent> {
  int _current = 0;
  double? rate;

/*  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }*/

  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getStoreDetails(this.widget.store?.id ?? widget.storeId!);
    this.widget.viewModel.getStoreProductList(this.widget.store?.id ?? widget.storeId!);
    this.widget.viewModel.createContentView(this.widget.store?.id ?? widget.storeId!, profileType.store);
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.viewModel.getStoreDetailsReport.status == ActionStatus.running
        ? Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CupertinoActivityIndicator(
                animating: true, // Control animation
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        : Scaffold(
            /*bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ButtonWidget(
          type: ButtonType.primary,
          title: "Create Product",
          onTap: () {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return CreateProductBottomSheet();
                });
          },
        ),
      ),*/
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
              centerTitle: false,
              title: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        Translations.of(context).currentLanguage == "ar"
                            ? widget.store?.arabicName ?? ""
                            : widget.store?.englishName ?? "",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  /*if (this.widget.viewModel.storeDetails?.verified == 1)
              Image.asset(
                Assets.images.verifyBlue.path,
                height: 20,
              ),*/
                ],
              ),
              actions: [
                this.widget.viewModel.followStoreReport.status == ActionStatus.running
                    ? Center(
                        child: CupertinoActivityIndicator(
                          animating: true, // Control animation
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          if (widget.viewModel.storeDetails == null) {
                            return;
                          }else {
                            print(widget.viewModel.storeDetails!.isFollowing);
                            if (widget.viewModel.storeDetails!.isFollowing ?? true) {
                              this.widget.viewModel.unfollowStore(widget.viewModel.storeDetails!);
                            } else {
                              this.widget.viewModel.followStore(widget.viewModel.storeDetails!);
                            }
                          }

                        },
                        child: Text(
                          (widget.viewModel.storeDetails!.isFollowing ?? true)
                              ? Translations.of(context).text("adsDetailsAddUnfollowLabel")
                              : Translations.of(context).text("adsDetailsAddFollowLabel"),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    Assets.images.shareIcon.path,
                    height: 20,
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180,
                        decoration: new BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Image.asset(
                          Assets.images.storeProfileBg.path,
                          height: 180,
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 108,
                                    height: 108,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: ClipRRect(
                                      child: Image.network(
                                        this.widget.viewModel.storeDetails?.logo ?? "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  /*Positioned(
                                    bottom: 0,
                                    child: Image.asset(
                                      Assets.images.selectpicIcon.path,
                                      height: 30,
                                    ),
                                  ),*/
                                  /*if (this.widget.viewModel.storeDetails?.verified == 1)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Image.asset(
                                        Assets.images.verify.path,
                                        height: 30,
                                      ),
                                    )*/
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            /*if (this.widget.viewModel.storeDetails?.verified == 1)
                              Text(
                                Translations.of(context).text("storeDetailsScreenTrustSellerLabel"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),*/
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 20,
                        child: InkWell(
                          onTap: () {
                            showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return StoreWorkTimeDialog(
                                  store: widget.viewModel.storeDetails!,
                                );
                              },
                              animationType: DialogTransitionType.slideFromTop,
                              curve: Curves.fastOutSlowIn,
                              duration: Duration(milliseconds: 300),
                            );
                          },
                          child: Image.asset(
                            Assets.images.workTimes.path,
                            height: 25,
                          ),
                        ),
                      ),
                      /*Positioned(
                        top: 20,
                        right: 20,
                        child: Image.asset(
                          Assets.images.editIcon.path,
                          height: 22,
                        ),
                      )*/
                    ],
                  ),
                  /*CarouselSlider(
                    items: _buildImages(Translations.of(context).currentLanguage == "ar"
                        ? this.widget.viewModel.storeDetails?.arabicCover ?? []
                        : this.widget.viewModel.storeDetails?.englishCover ?? []),
                    options: CarouselOptions(
                      height: 192,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: (Translations.of(context).currentLanguage == "ar"
                                      ? this.widget.viewModel.storeDetails?.arabicCover ?? []
                                      : this.widget.viewModel.storeDetails?.englishCover ?? [])
                                  .length >
                              1
                          ? true
                          : false,
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
                  ),*/
                  /*SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: AnimatedSmoothIndicator(
                      activeIndex: _current,
                      count: (Translations.of(context).currentLanguage == "ar"
                              ? this.widget.viewModel.storeDetails?.arabicCover ?? []
                              : this.widget.viewModel.storeDetails?.englishCover ?? [])
                          .length,
                      effect: CustomizableEffect(
                        spacing: 6,
                        activeDotDecoration: DotDecoration(
                          color: Theme.of(context).primaryColor,
                          height: 10,
                          width: 10,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        dotDecoration: DotDecoration(
                            color: Color(0xffd9d9d9),
                            height: 8,
                            width: 8,
                            borderRadius: BorderRadius.circular(100),
                            dotBorder: DotBorder(
                              color: Color(0xff979797),
                            )),
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${this.widget.viewModel.storeDetails?.followers ?? 0} ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  TextSpan(
                                    text: Translations.of(context).text("storeDetailsScreenFollowersLabel"),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 17,
                              width: 1,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff979797),
                                  width: 1,
                                ),
                              ),
                            ),
                            /*RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: this.widget.viewModel.storeDetails?.date ?? "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),*/
                            Container(
                              height: 17,
                              width: 1,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff979797),
                                  width: 1,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${this.widget.viewModel.storeDetails?.views ?? 0} ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  TextSpan(
                                    text: Translations.of(context).text("storeDetailsScreenViewsLabel"),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "5 ",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: Translations.of(context).text("storeDetailsScreenDaysLeftLabel"),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //if (widget.homeType == HomeType.commercial)
                            Row(
                              children: [
                                if (widget.viewModel.storeDetails?.tiktokLink?.isNotEmpty ?? false) ...[
                                  InkWell(
                                    onTap: () {
                                      launchURl(widget.viewModel.storeDetails?.tiktokLink ?? "");
                                    },
                                    child: Image.asset(
                                      Assets.images.tiktok.path,
                                      height: 22,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                ],
                                if (widget.viewModel.storeDetails?.instagramLink?.isNotEmpty ?? false) ...[
                                  InkWell(
                                    onTap: () {
                                      launchURl(widget.viewModel.storeDetails?.instagramLink ?? "");
                                    },
                                    child: Image.asset(
                                      Assets.images.instagram.path,
                                      height: 22,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                ],
                                if (widget.viewModel.storeDetails?.snapchatLink?.isNotEmpty ?? false) ...[
                                  InkWell(
                                    onTap: () {
                                      launchURl(widget.viewModel.storeDetails?.snapchatLink ?? "");
                                    },
                                    child: Image.asset(
                                      Assets.images.snapchatPng.path,
                                      height: 22,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                ],
                                if (widget.viewModel.storeDetails?.facebookLink?.isNotEmpty ?? false) ...[
                                  InkWell(
                                    onTap: () {
                                      launchURl(widget.viewModel.storeDetails?.facebookLink ?? "");
                                    },
                                    child: Image.asset(
                                      Assets.images.facebook.path,
                                      height: 22,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                ],
                                if (widget.viewModel.storeDetails?.youtubeLink?.isNotEmpty ?? false)
                                  InkWell(
                                    onTap: () {
                                      launchURl(widget.viewModel.storeDetails?.youtubeLink ?? "");
                                    },
                                    child: Image.asset(
                                      Assets.images.youtube.path,
                                      height: 22,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
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
                                  "${this.widget.viewModel.storeDetails?.rating?.count ?? 0} ${Translations.of(context).text("storeDetailsScreenVotesLabel")}",
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
                                    initialRating:
                                        this.widget.viewModel.storeDetails?.rating?.rating?.toDouble() ?? 0.0,
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
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translations.of(context).text("storeDetailsScreenDescriptionLabel"),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Image.asset(
                              Assets.images.flagIcon.path,
                              height: 16,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: this.widget.viewModel.storeDetails?.description ?? "",
                                style: TextStyle(
                                  color: Color(0xff858585),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translations.of(context).text("storeDetailsScreenAllProductsLabel"),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  Translations.of(context).text("storeDetailsScreenViewAllLabel"),
                                  style: TextStyle(
                                    color: Color(0xff7a7a7a),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        /*  SizedBox(
                          height: 20,
                        ),
                        this.widget.viewModel.getStoreProductListReport.status == ActionStatus.running
                            ? Center(
                                child: CupertinoActivityIndicator(
                                  animating: true, // Control animation
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            : this.widget.viewModel.storeProductList.isEmpty
                                ? SizedBox.shrink()
                                : DynamicHeightGridView(
                                    itemCount: this.widget.viewModel.storeProductList.length,
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    physics: NeverScrollableScrollPhysics(),
                                    builder: (BuildContext context, int index) {
                                      final HomeProduct product = this.widget.viewModel.storeProductList[index];
                                      return AllProductItem(
                                        product: product,
                                        currency: Translations.of(context).currentLanguage == "ar"
                                            ? this.widget.viewModel.storeDetails?.arCurrency ?? "د.ك"
                                            : this.widget.viewModel.storeDetails?.enCurrency ?? "KWD",
                                      );
                                    },
                                  ),*/
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }

  launchURl(String url) {
    try {
      launchUrl(Uri.parse(url));
    } on Exception {
      showToast('Link is not available.');
    }
  }

  _buildImages(List<String> images) {
    List<Widget> services = images
        .map(
          (e) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(e),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
        .toList();
    return services;
  }
}

class AllProductItem extends StatelessWidget {
  final HomeProduct product;
  final String currency;

  const AllProductItem({
    super.key,
    required this.product,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Color(0x7fdadada),
            offset: Offset(0, 6),
            blurRadius: 11,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                new Container(
                  width: double.infinity,
                  height: 127,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(product.image ?? ""),
                    ),
                  ),
                ),
                if (product.featured == "yes")
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 58,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Color(0xff1081ae),
                      ),
                      child: Center(
                        child: Text(
                          "Featured",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  right: 10,
                  bottom: 5,
                  child: Image.asset(
                    Assets.images.editIcon.path,
                    height: 16,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 10,
                  child: Image.asset(
                    Assets.images.flagIcon.path,
                    color: Colors.white,
                    height: 16,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Brand",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "769590",
                  style: TextStyle(
                    color: Color(0xff7a7a7a),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              Translations.of(context).currentLanguage == "ar" ? product.arabicName ?? "" : product.englishName ?? "",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.price?.toString() ?? "",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 11,
                  ),
                ),
                /*new Text(
                  "1729 kwd",
                  style: TextStyle(
                    color: Color(0xffeb3a45),
                    fontSize: 11,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),*/
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    decoration: new BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        Translations.of(context).text("homeScreenProductItemViewDetailsLabel"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Image.asset(
                      Assets.images.fav.path,
                      color: Color(0xff33363f).withOpacity(0.4),
                      height: 20,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
