import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/feature_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/ads_widget.dart';
import 'package:dealz/ui/ads/image_viewer.dart';
import 'package:dealz/ui/products/product_details_widgets/add_comment_widget.dart';
import 'package:dealz/ui/products/product_details_widgets/comment_list.dart';
import 'package:dealz/ui/products/product_details_widgets/favorite_icon.dart';
import 'package:dealz/ui/products/product_details_widgets/feature_item_widget.dart';
import 'package:dealz/ui/products/rating_dialogue.dart';
import 'package:dealz/ui/products/send_message_dialog.dart';
import 'package:dealz/ui/profile/user_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/home_view_model.dart';

class AdsDetailsView extends StatelessWidget {
  final MyAdsModel adsModel;

  const AdsDetailsView({super.key, required this.adsModel});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AdsDetailsViewContent(
        viewModel: viewModel,
        adsModel: adsModel,
      ),
    );
  }
}

class _AdsDetailsViewContent extends StatefulWidget {
  final MyAdsModel adsModel;
  final HomeViewModel viewModel;

  const _AdsDetailsViewContent({required this.adsModel, required this.viewModel});

  @override
  State<_AdsDetailsViewContent> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<_AdsDetailsViewContent> {
  double rate = 0;

  ProgressDialog? progressDialog;

  int _current = 0;

  CarouselController carouselController = CarouselController();

  @override
  void didUpdateWidget(covariant _AdsDetailsViewContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.createRatingReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.createRatingReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.createRatingReport.msg}");
        this.widget.viewModel.createRatingReport.status = null;
      } else if (this.widget.viewModel.createRatingReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.viewModel.createRatingReport.status = null;
        showToast("Rating added successfully");
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.createRatingReport.status = null;
    });
  }

  @override
  void initState() {
    this.widget.viewModel.createContentView(widget.adsModel.id!, profileType.advertisement);
    this.widget.viewModel.getSimilarAds(widget.adsModel.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          widget.adsModel.getTitle(Translations.of(context).currentLanguage),
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
          if (widget.viewModel.user != null)
            FavoriteIcon(
              product: widget.adsModel,
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
                          builder: (context) => ImageViewer(imageUrl: widget.adsModel.images![_current].image!)));
                },
                child: CarouselSlider(
                  items: _buildImages((widget.adsModel.images ?? [])),
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
                  widget.adsModel.getTitle(Translations.of(context).currentLanguage),
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
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.adsModel.price?.toString() ?? "0.0",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: "kwd",
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
                              text: "${widget.adsModel.createdAt?.day ?? 1} ",
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                color: Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: DateFormat("MMMM").format(widget.adsModel.createdAt ?? DateTime.now()),
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
                              text: "${widget.adsModel.views} ",
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
              if (widget.adsModel.features?.isNotEmpty ?? false)
                Center(
                  child: Container(
                    height: 70,
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final FeatureModel feature = widget.adsModel.features![index];
                          return FeatureItemWidget(
                            title: feature.name(Translations.of(context).currentLanguage),
                            img: feature.image ?? "",
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: widget.adsModel.features?.length ?? 0),
                  ),
                ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  if (this.widget.viewModel.user != null)
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RatingDialog(
                          contentId: widget.adsModel.id!,
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
                          "${widget.adsModel.rating?.count ?? 0} ${Translations.of(context).text("storeDetailsScreenVotesLabel")}",
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
                            initialRating: widget.adsModel.rating?.rating?.toDouble() ?? 0,
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
                widget.adsModel.getDescription(Translations.of(context).currentLanguage),
                style: TextStyle(
                  color: Color(0xff858585),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
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
              ),
              SizedBox(
                height: 15,
              ),
              CommentList(
                myAdsModel: widget.adsModel,
                currentUser: widget.viewModel.user,
              ),
              SizedBox(
                height: 30,
              ),
              AddCommentWidget(
                adsModel: widget.adsModel,
              ),
              SizedBox(
                height: 30,
              ),
              if (widget.adsModel.long != null && widget.adsModel.lat != null)
                map(double.parse(widget.adsModel.lat!), double.parse(widget.adsModel.long!)),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserProfileScreen(
                        user: widget.adsModel.user!,
                      ),
                    ),
                  );
                },
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
                          image: NetworkImage(widget.adsModel.user?.image ?? ""),
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
                            text: widget.adsModel.user?.name ?? "",
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
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        launch("tel://${widget.adsModel.whatsApp}");
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
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SendMessageDialog(
                              userId: widget.adsModel.userId!,
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffee7a37),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.images.chat.path,
                              height: 22,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              Translations.of(context).text("adsDetailsAddChatLabel"),
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
                    child: InkWell(
                      onTap: () {
                        this.widget.viewModel.postWhatsappClick(widget.adsModel.id!);
                        whatsapp(widget.adsModel.whatsApp ?? "");
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
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
                ),
              ),
              SizedBox(
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
                    ),
            ],
          ),
        ),
      ),
    );
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

  map(double lat, double long) {
    return Container(
      height: 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, long),
            zoom: 15,
          ),
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          scrollGesturesEnabled: true,
          markers: Set.of(
            [
              Marker(
                markerId: MarkerId("1"),
                position: LatLng(lat, long),
                visible: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
