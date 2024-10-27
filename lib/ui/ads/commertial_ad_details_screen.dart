import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/image_viewer.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';

class CommertialAdsDetailsScreen extends StatelessWidget {
  final MyAdsModel myAdsModel;

  const CommertialAdsDetailsScreen({super.key, required this.myAdsModel});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _CommertialAdsDetailsScreenContent(
        viewModel: viewModel,
        myAdsModel: myAdsModel,
      ),
    );
  }
}

class _CommertialAdsDetailsScreenContent extends StatefulWidget {
  final MyAdsModel myAdsModel;
  final HomeViewModel viewModel;

  const _CommertialAdsDetailsScreenContent({super.key, required this.myAdsModel, required this.viewModel});

  @override
  State<_CommertialAdsDetailsScreenContent> createState() => _CommertialAdsDetailsScreenState();
}

class _CommertialAdsDetailsScreenState extends State<_CommertialAdsDetailsScreenContent> {
  int _current = 0;

  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    this.widget.viewModel.createContentView(widget.myAdsModel.id!, profileType.advertisement);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          widget.myAdsModel.getTitle(Translations.of(context).currentLanguage),
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
            matchTextDirection: true,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Image.asset(
              Assets.images.share.path,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            child: Image.asset(
              Assets.images.download.path,
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
                          builder: (context) => ImageViewer(imageUrl: widget.myAdsModel.images![_current].image!)));
                },
                child: _buildImages((widget.myAdsModel.images ?? [])),
              ),
              SizedBox(
                height: 20,
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      carouselController.previousPage();
                    },
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          Assets.images.backArrow.path,
                          color: Colors.white,
                          matchTextDirection: true,
                        ),
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: new Text(
                      "${_current + 1} Of ${widget.myAdsModel.images?.length ?? 0}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      carouselController.nextPage();
                    },
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: RotatedBox(
                          quarterTurns: -2,
                          child: Image.asset(
                            Assets.images.backArrow.path,
                            color: Colors.white,
                            matchTextDirection: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),*/
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: new Text(
                  "${widget.myAdsModel.views} ${Translations.of(context).text("storeDetailsScreenViewsLabel")}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (widget.myAdsModel.phone != null) launch("tel://${widget.myAdsModel.phone}");
                      },
                      child: new Container(
                        height: 50,
                        decoration: new BoxDecoration(
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
                            new Text(
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
                    child: InkWell(
                      onTap: () {
                        if (widget.myAdsModel.whatsApp != null) {
                          this.widget.viewModel.postWhatsappClick(widget.myAdsModel.id!);
                          whatsapp(widget.myAdsModel.whatsApp!);
                        }
                      },
                      child: new Container(
                        height: 50,
                        decoration: new BoxDecoration(
                          color: Color(0xff07be83),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.images.whatsapp.path,
                              height: 22,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            new Text(
                              Translations.of(context).text("CreateAdsWhatsAppTitle"),
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
                ],
              ),
              SizedBox(
                height: 10,
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
    Widget services = images
        .map(
          (e) => Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(e.image ?? ""),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
        .toList()
        .first;
    return services;
  }
}
