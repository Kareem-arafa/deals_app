import 'dart:io';

import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_dropdown_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/custom_upload_pictures.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/commercial_store_model.dart';
import 'package:dealz/data/models/create_trend_ads_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/data/models/my_store_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/create_ads/plans/plan_one_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TrendAdd extends StatelessWidget {
  final trendsSize? initialSize;

  const TrendAdd({super.key, this.initialSize});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _TrendAddContent(
        viewModel: viewModel,
        initialSize: initialSize,
      ),
    );
  }
}

class _TrendAddContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final trendsSize? initialSize;

  const _TrendAddContent({required this.viewModel, this.initialSize});

  @override
  State<_TrendAddContent> createState() => _TrendAddState();
}

class _TrendAddState extends State<_TrendAddContent> {
  TextEditingController titleController = TextEditingController();
  trendsTypes trendType = trendsTypes.none;

  File? image;

  bool firstVertical = false;
  bool secondVertical = false;
  bool bigSelected = false;
  bool smallSelected = false;

  var selectedContent;

  CommercialStoreModel? selectedStore;

  @override
  void initState() {
    if (widget.initialSize == trendsSize.big) {
      bigSelected = true;
    } else if (widget.initialSize == trendsSize.vertical) {
      firstVertical = true;
    }
    this.widget.viewModel.getTrendSizes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.viewModel.getTrendSizesReport.status == ActionStatus.running
        ? Center(
            child: CupertinoActivityIndicator(
              animating: true, // Control animation
              color: Theme.of(context).primaryColor,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: new Text(
                  Translations.of(context).text("createTrendAdsTypes"),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        firstVertical = true;
                        secondVertical = false;
                        bigSelected = false;
                        smallSelected = false;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 250,
                          width: (MediaQuery.of(context).size.width - 42) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(Assets.images.logo.path),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 250,
                          width: (MediaQuery.of(context).size.width - 42) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: firstVertical,
                                  onChanged: (value) {
                                    setState(() {
                                      firstVertical = true;
                                      secondVertical = false;
                                      bigSelected = false;
                                      smallSelected = false;
                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                  fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context).primaryColor;
                                    },
                                  ),
                                ),
                                Text(
                                  "${getTrendTypePrice(trendsSize.vertical)} KWD",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "175w x 250h px",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        firstVertical = false;
                        secondVertical = true;
                        bigSelected = false;
                        smallSelected = false;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 250,
                          width: (MediaQuery.of(context).size.width - 42) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(Assets.images.logo.path),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 250,
                          width: (MediaQuery.of(context).size.width - 42) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: secondVertical,
                                  onChanged: (value) {
                                    setState(() {
                                      firstVertical = false;
                                      secondVertical = true;
                                      bigSelected = false;
                                      smallSelected = false;
                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                  fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context).primaryColor;
                                    },
                                  ),
                                ),
                                Text(
                                  "${getTrendTypePrice(trendsSize.vertical)} KWD",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "175w x 250h px",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          firstVertical = false;
                          secondVertical = false;
                          bigSelected = true;
                          smallSelected = false;
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(Assets.images.logo.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: bigSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        firstVertical = false;
                                        secondVertical = false;
                                        bigSelected = true;
                                        smallSelected = false;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).primaryColor;
                                      },
                                    ),
                                  ),
                                  Text(
                                    "${getTrendTypePrice(trendsSize.big)} KWD",
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "375w x 200h px",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              /*SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          firstVertical = false;
                          secondVertical = false;
                          bigSelected = false;
                          smallSelected = true;
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(Assets.images.logo.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: smallSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        firstVertical = false;
                                        secondVertical = false;
                                        bigSelected = false;
                                        smallSelected = true;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).primaryColor;
                                      },
                                    ),
                                  ),
                                  Text(
                                    "${getTrendTypePrice(trendsSize.small)} KWD",
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "375w x 100h px",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),*/
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: new Text(
                  Translations.of(context).text("CreateAdsArabicTitle"),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                type: TextFieldType.text,
                hint: Translations.of(context).text("CreateAdsArabicTitle"),
                controller: titleController,
              ),
              SizedBox(
                height: 25,
              ),
              CustomUploadPictures(
                title: Translations.of(context).text("CreateAdsAddPhotosTitle"),
                onImageSelected: (file) {
                  image = file;
                },
                onImageRemoved: (file) {
                  image = null;
                },
                isMultiImage: false,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  Translations.of(context).text("createTrendAdsChooseContentType"),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CustomDropdownButton(
                items: trendsTypes.values,
                hint: Translations.of(context).text("createTrendAdsChooseContentType"),
                value: trendType,
                onChange: (value) {
                  trendType = value;
                  if (value == trendsTypes.store || value == trendsTypes.product) {
                    this.widget.viewModel.getCommercialStores(true);
                  } else if (value == trendsTypes.ordinary || value == trendsTypes.commercial) {
                    this.widget.viewModel.getMyAds();
                  }
                  selectedContent = null;
                  setState(() {});
                },
              ),
              trendType != trendsTypes.none
                  ? (widget.viewModel.getMyAdsReport.status == ActionStatus.running ||
                          widget.viewModel.getCommercialStoresReport.status == ActionStatus.running)
                      ? Center(
                          child: CupertinoActivityIndicator(
                            animating: true, // Control animation
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            if (trendType == trendsTypes.product)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: new Text(
                                      "اختر متجرك",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomDropdownButton(
                                    items: this.widget.viewModel.commercialStore,
                                    hint: "اختر متجرك",
                                    value: selectedStore,
                                    onChange: (value) {
                                      selectedStore = value;
                                      selectedContent = null;
                                      widget.viewModel.getStoreProducts(selectedStore!.id!,false);
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            trendType == trendsTypes.product
                                ? widget.viewModel.getStoreProductsReport.status == ActionStatus.running
                                    ? Center(
                                        child: CupertinoActivityIndicator(
                                          animating: true, // Control animation
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            child: new Text(
                                              Translations.of(context).text("createTrendAdsChooseContent"),
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomDropdownButton(
                                            items: widget.viewModel.storeProducts,
                                            hint: Translations.of(context).text("createTrendAdsChooseContent"),
                                            value: selectedContent,
                                            onChange: (value) {
                                              selectedContent = value;
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: new Text(
                                          Translations.of(context).text("createTrendAdsChooseContent"),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (trendType == trendsTypes.commercial) {
                                            _showCommercialAdsBottomSheet(context, (commercialAds) {
                                              selectedContent = commercialAds;
                                              setState(() {});
                                            });
                                          }
                                        },
                                        child: IgnorePointer(
                                          ignoring: trendType == trendsTypes.commercial,
                                          child: CustomDropdownButton(
                                            items: trendType == trendsTypes.store
                                                ? this.widget.viewModel.commercialStore
                                                : trendType == trendsTypes.ordinary
                                                    ? this
                                                        .widget
                                                        .viewModel
                                                        .myAds
                                                        .where((ads) => ads.type == "ordinary")
                                                        .toList()
                                                    : [],
                                            hint: Translations.of(context).text("createTrendAdsChooseContent"),
                                            value: selectedContent,
                                            onChange: (value) {
                                              selectedContent = value;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                      if (trendType == trendsTypes.commercial && selectedContent != null)
                                        Container(
                                          height: 100,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Theme.of(context).primaryColor),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                selectedContent.images?.first.image ?? "",
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                          ],
                        )
                  : SizedBox(),
              SizedBox(
                height: 40,
              ),
              ButtonWidget(
                type: ButtonType.primary,
                title: Translations.of(context).text("CreateAdsButtonTitle"),
                onTap: () {
                  trendsSize? size;
                  if (firstVertical || secondVertical) {
                    size = trendsSize.vertical;
                  } else if (bigSelected) {
                    size = trendsSize.big;
                  }

                  if (titleController.text.isEmpty) {
                    return showToast(Translations.of(context).text("createAdsArabicTitleErrorMessage"));
                  }
                  if (image == null) {
                    return showToast(Translations.of(context).text("createAdsImagesTitleErrorMessage"));
                  }
                  if (size == null) {
                    return showToast(Translations.of(context).text("createTrendAdsSizeError"));
                  }

                  CreateTrendAdsModel createTrendAdsModel = CreateTrendAdsModel(
                    title: titleController.text,
                    image: image!,
                    type: trendType,
                    size: size,
                    contentId: selectedContent?.id!,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlanOneScreen(
                        createTrendAdsModel: createTrendAdsModel,
                        adType: "trend",
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
  }

  String getTrendTypePrice(trendsSize size) {
    num price = 0.0;
    this.widget.viewModel.trendSizes.forEach((trendsSize) {
      if (trendsSize.size == size.name) {
        price = trendsSize.price ?? 0.0;
      }
    });

    return price.toString();
  }

  void _showCommercialAdsBottomSheet(BuildContext context, Function(MyAdsModel) onSelect) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Translations.of(context).text("selectAnAds"),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: this.widget.viewModel.myAds.where((ads) => ads.type == "commercial").toList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, index);
                        onSelect(this.widget.viewModel.myAds.where((ads) => ads.type == "commercial").toList()[index]);
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(this
                                    .widget
                                    .viewModel
                                    .myAds
                                    .where((ads) => ads.type == "commercial")
                                    .toList()[index]
                                    .images
                                    ?.first
                                    .image ??
                                ""), // Replace with your image URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
