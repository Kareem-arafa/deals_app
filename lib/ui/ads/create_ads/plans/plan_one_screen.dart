import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/create_commercial_ads_model.dart';
import 'package:dealz/data/models/create_ordinary_ads_model.dart';
import 'package:dealz/data/models/create_store_model.dart';
import 'package:dealz/data/models/create_trend_ads_model.dart';
import 'package:dealz/data/models/packages_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PlanOneScreen extends StatelessWidget {
  final CreateOrdinaryAdsModel? createOrdinaryAdsModel;
  final CreateTrendAdsModel? createTrendAdsModel;
  final CreateCommercialAdsModel? createCommercialAdsModel;
  final CreateStoreModel? createStoreModel;
  final String adType;
  final bool isUpgrade;
  final Function(PackageModel)? onSelectPackage;

  const PlanOneScreen({
    super.key,
    this.createOrdinaryAdsModel,
    required this.adType,
    this.createTrendAdsModel,
    this.createCommercialAdsModel,
    this.createStoreModel,
    this.isUpgrade = false,
    this.onSelectPackage,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _PlanOneScreenContent(
        viewModel: viewModel,
        ordinaryAdsModel: createOrdinaryAdsModel,
        createTrendAdsModel: createTrendAdsModel,
        createCommercialAdsModel: createCommercialAdsModel,
        adType: adType,
        createStoreModel: createStoreModel,
        onSelectPackage: onSelectPackage,
        isUpgrade: isUpgrade,
      ),
    );
  }
}

class _PlanOneScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final CreateOrdinaryAdsModel? ordinaryAdsModel;
  final CreateTrendAdsModel? createTrendAdsModel;
  final CreateStoreModel? createStoreModel;

  final CreateCommercialAdsModel? createCommercialAdsModel;
  final String adType;

  final bool isUpgrade;
  final Function(PackageModel)? onSelectPackage;

  const _PlanOneScreenContent({
    required this.viewModel,
    this.ordinaryAdsModel,
    required this.adType,
    this.createTrendAdsModel,
    this.createCommercialAdsModel,
    this.createStoreModel,
    this.isUpgrade = false,
    this.onSelectPackage,
  });

  @override
  State<_PlanOneScreenContent> createState() => _PlanOneScreenState();
}

class _PlanOneScreenState extends State<_PlanOneScreenContent> {
  int? selectedPlan;

  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getPackages();
  }

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _PlanOneScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.createOrdinaryAdsReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.createOrdinaryAdsReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }

        //  showToast("${this.widget.viewModel.createOrdinaryAdsReport.msg}");
        this.widget.viewModel.createOrdinaryAdsReport.status = null;
      } else if (this.widget.viewModel.createOrdinaryAdsReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("Your Ads created successfully");
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        this.widget.viewModel.createOrdinaryAdsReport.status = null;
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.createOrdinaryAdsReport.status = null;
    });
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
      body: this.widget.viewModel.getPackagesReport.status == ActionStatus.running
          ? Center(
              child: CupertinoActivityIndicator(
                animating: true, // Control animation
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
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
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Translations.of(context).text("packagesScreenTitle"),
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.5,
                                      fontFamily: "Almarai"),
                                ),
                                TextSpan(
                                  text: Translations.of(context).text("packagesScreenAppNameTitle"),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 22,
                                      letterSpacing: -0.5,
                                      fontFamily: "Almarai"),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ListView.separated(
                    itemCount: this.widget.viewModel.packages.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (_, int index) {
                      final plan = this.widget.viewModel.packages[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedPlan = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: selectedPlan == index ? Theme.of(context).primaryColor : Color(0xffd4d4d4),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        plan.name(Translations.of(context).currentLanguage),
                                        style: TextStyle(
                                          color: Color(0xff2b3242),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "${plan.price} ",
                                              style: TextStyle(
                                                color: Color(0xff2b3242),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Almarai",
                                              ),
                                            ),
                                            if (plan.duration != null)
                                              TextSpan(
                                                text:
                                                    "/${plan.duration} ${Translations.of(context).text("packagesScreenDaysTitle")}",
                                                style: TextStyle(
                                                  color: Color(0xff2b3242),
                                                  fontSize: 11,
                                                  fontFamily: "Almarai",
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          if (plan.pushedOnTop != null && plan.pushedOnTop! > 0)
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Theme.of(context).primaryColor,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${Translations.of(context).text("packagesScreenPushToTop")}${plan.pushedOnTop}${Translations.of(context).text("packagesScreenTimes")}",
                                                      style: TextStyle(
                                                        color: Color(0xff2b3242),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (plan.featured == 'yes')
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Theme.of(context).primaryColor,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      Translations.of(context).text("packagesScreenFeaturedAd"),
                                                      style: TextStyle(
                                                        color: Color(0xff2b3242),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (plan.pinInCategories == 'yes')
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Theme.of(context).primaryColor,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      Translations.of(context).text("packagesScreenPinInCategories"),
                                                      style: TextStyle(
                                                        color: Color(0xff2b3242),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (plan.pinInProductList == 'yes')
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Theme.of(context).primaryColor,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      Translations.of(context).text("packagesScreenPinInProductsList"),
                                                      style: TextStyle(
                                                        color: Color(0xff2b3242),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.network(
                                      plan.image ?? "",
                                      height: 48,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => SizedBox(
                      height: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                    child: ButtonWidget(
                      type: ButtonType.primary,
                      title: Translations.of(context).text("settingScreenDoneButtonTitle"),
                      onTap: () {
                        if (selectedPlan == null) {
                          showToast(Translations.of(context).text("packagesScreenSelectPlanError"));
                          return;
                        }
                        if (widget.isUpgrade) {
                          Navigator.of(context).pop();
                          widget.onSelectPackage!(this.widget.viewModel.packages[selectedPlan!]);
                        } else {
                          if (widget.adType == "ordinary") {
                            this.widget.ordinaryAdsModel!.packageId = this.widget.viewModel.packages[selectedPlan!].id;
                            this.widget.viewModel.createOrdinaryAds(widget.ordinaryAdsModel!);
                          } else if (widget.adType == "trend") {
                            this.widget.createTrendAdsModel!.packageId =
                                this.widget.viewModel.packages[selectedPlan!].id;
                            this.widget.viewModel.createTrendAds(this.widget.createTrendAdsModel!);
                          } else if (widget.adType == "commercial") {
                            this.widget.createCommercialAdsModel!.packageId =
                                this.widget.viewModel.packages[selectedPlan!].id;
                            this.widget.viewModel.createCommercialAds(this.widget.createCommercialAdsModel!);
                          } else if (widget.adType == "store") {
                            this.widget.createStoreModel!.packageId = this.widget.viewModel.packages[selectedPlan!].id;
                            this.widget.viewModel.createStore(this.widget.createStoreModel!);
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
