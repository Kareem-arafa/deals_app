import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/ads_details_by_id_screen.dart';
import 'package:dealz/ui/ads/commercial_ads_by_id.dart';
import 'package:dealz/ui/ads/create_ads/plans/plan_one_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _MyAdsScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _MyAdsScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _MyAdsScreenContent({required this.viewModel});

  @override
  State<_MyAdsScreenContent> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<_MyAdsScreenContent> {
  int selectedBody = 0;

  @override
  void initState() {
    super.initState();
    widget.viewModel.getMyAds();
  }

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _MyAdsScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.updateAdsReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.updateAdsReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.updateAdsReport.msg}");
        this.widget.viewModel.updateAdsReport.status = null;
      } else if (this.widget.viewModel.updateAdsReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.viewModel.updateAdsReport.status = null;

        showToast("Ads Updated Successfully");
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.updateAdsReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          title: Text(
            Translations.of(context).text("MyAdsScreenTitle"),
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          /* bottom: PreferredSize(
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
                    fontFamily: 'Poppins',
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
                      text: "Active",
                    ),
                    Tab(
                      text: "Waiting",
                    ),
                    Tab(
                      text: "Archived",
                    )
                  ],
                ),
              ),
            ),
          ),*/
        ),
        body: this.widget.viewModel.getMyAdsReport.status == ActionStatus.running
            ? Center(
                child: CupertinoActivityIndicator(
                  animating: true, // Control animation
                  color: Theme.of(context).primaryColor,
                ),
              )
            : MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                removeTop: true,
                child: ListView.separated(
                  itemCount: this.widget.viewModel.myAds.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  itemBuilder: (_, int index) {
                    return InkWell(
                      onTap: () {
                        if (widget.viewModel.myAds[index].type == "ordinary") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdsDetailsByIdView(adsId: widget.viewModel.myAds[index].id!),
                            ),
                          );
                        } else if (widget.viewModel.myAds[index].type == "commercial") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommercialAdsByIdScreen(adsId: widget.viewModel.myAds[index].id!),
                            ),
                          );
                        }
                      },
                      child: MyAdItem(
                        myAdsModel: widget.viewModel.myAds[index],
                        onUpdate: () {
                          this.widget.viewModel.updateAdsStatus(widget.viewModel.myAds[index]);
                        },
                        onUpgrade: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlanOneScreen(
                                adType: widget.viewModel.myAds[index].type!,
                                isUpgrade: true,
                                onSelectPackage: (package) {
                                  this
                                      .widget
                                      .viewModel
                                      .upgradeAds(package.id!, widget.viewModel.myAds[index], package.duration!);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => SizedBox(
                    height: 15,
                  ),
                ),
              ),
      ),
    );
  }
}

class MyAdItem extends StatelessWidget {
  final MyAdsModel myAdsModel;
  final Function() onUpgrade;
  final Function() onUpdate;

  const MyAdItem({
    super.key,
    required this.myAdsModel,
    required this.onUpgrade,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x7fdadada),
            offset: Offset(0, 5),
            blurRadius: 10,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 116,
                      height: 104,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              (myAdsModel.images?.isEmpty ?? true) ? "" : myAdsModel.images?.first.image ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myAdsModel.getTitle(Translations.of(context).currentLanguage),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            myAdsModel.user?.name ?? "",
                            style: TextStyle(
                              color: Color(0xffb6b6b6),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${myAdsModel.remainingDays} ",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: Translations.of(context).text("homeScreenProductItemDaysLabel"),
                                  style: TextStyle(
                                    color: Color(0xffb6b6b6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width: double.infinity,
            height: 42,
            decoration: BoxDecoration(
              color: Color(0xffe1f3ff),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.images.eye.path,
                        height: 18,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "${myAdsModel.views} ",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: Translations.of(context).text("storeDetailsScreenViewsLabel"),
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 10,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.images.whatsapp.path,
                        height: 18,
                        color: Color(0xff3faf83),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "${myAdsModel.clicks} ",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: Translations.of(context).text("myAdsItemClicksLabel"),
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 10,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                 Expanded(
                        child: InkWell(
                          onTap: () {
                            onUpgrade();
                          },
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                Translations.of(context).text("myAdsItemUpgradeLabel"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onUpdate();
                    },
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          myAdsModel.active == 1 ? Translations.of(context).text("myAdsItemDeActivateLabel") : Translations.of(context).text("myAdsItemActivateLabel"),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
