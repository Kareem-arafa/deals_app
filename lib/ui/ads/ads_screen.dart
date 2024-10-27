import 'package:dealz/common/title_with_viewAll.dart';
import 'package:dealz/data/models/category_model.dart';
import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/data/models/store_details_model.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/ads_slider.dart';
import 'package:dealz/ui/ads/ads_widget.dart';
import 'package:dealz/ui/categories/all_ads_categories_screen.dart';
import 'package:dealz/ui/categories/all_categories_screen.dart';
import 'package:dealz/ui/categories/categories_widget.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/products/all_products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AdsScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _AdsScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _AdsScreenContent({super.key, required this.viewModel});

  @override
  State<_AdsScreenContent> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<_AdsScreenContent> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getSliderAds();
    widget.viewModel.getSectionAds("ads");
    widget.viewModel.getOrdinaryAds();
    widget.viewModel.getMostWantedAds();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  this.widget.viewModel.getSliderAdsReport.status == ActionStatus.running
                      ? CupertinoActivityIndicator(
                          animating: true, // Control animation
                          color: Theme.of(context).primaryColor,
                        )
                      : AdsSlider(
                          sliders: this
                              .widget
                              .viewModel
                              .adsSliders
                              .map((e) => Sliders(
                                    id: e.id,
                                    image: e.image,
                                    link: e.link,
                                    arabicName: e.arName,
                                    englishName: e.enName,
                                  ))
                              .toList(),
                        ),
                  SizedBox(
                    height: 40,
                  ),
                  this.widget.viewModel.getSectionAdsReport.status == ActionStatus.running
                      ? CupertinoActivityIndicator(
                          animating: true, // Control animation
                          color: Theme.of(context).primaryColor,
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            TitleWithViewAll(
                              title: Translations.of(context).text("AdvertisementsScreenAllCategoryTitle"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AllAdsCategoriesScreen(
                                      categories: this
                                          .widget
                                          .viewModel
                                          .adsSections
                                          .map((e) => CategoryModel(
                                                id: e.id,
                                                image: e.image,
                                                nameAr: e.arName,
                                                nameEn: e.enName,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            CategoriesWidget(
                              isFromAds: true,
                              categories: this
                                  .widget
                                  .viewModel
                                  .adsSections
                                  .map((e) => CategoryModel(
                                        id: e.id,
                                        image: e.image,
                                        nameAr: e.arName,
                                        nameEn: e.enName,
                                      ))
                                  .toList(),
                              scrollPhysics: NeverScrollableScrollPhysics(),
                              isFromAll: false,
                            ),
                          ],
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    Translations.of(context).text("AdvertisementsScreenSpecialAdsTitle"),
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
            this.widget.viewModel.getOrdinaryAdsReport.status == ActionStatus.running
                ? Center(
                    child: CupertinoActivityIndicator(
                      animating: true, // Control animation
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: AdsWidget(
                      ads: this.widget.viewModel.ordinaryAds,
                    ),
                  ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    Translations.of(context).text("AdvertisementsScreenMostWatchedTitle"),
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
            this.widget.viewModel.getMostWantedAdsReport.status == ActionStatus.running
                ? Center(
                    child: CupertinoActivityIndicator(
                      animating: true, // Control animation
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: AdsWidget(
                      ads: widget.viewModel.mostWantedAds,
                    ),
                  ),
            SizedBox(
              height: 15,
            ),
            /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TitleWithViewAll(
                title: "See All In Realstate",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllProductsView(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AdsWidget(
                products: [],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TitleWithViewAll(
                title: "See All In Engines",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllProductsView(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AdsWidget(
                products: [],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TitleWithViewAll(
                title: "See All In Elctronics",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllProductsView(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AdsWidget(
                products: [],
              ),
            ),
            SizedBox(
              height: 20,
            ),*/
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    widget.viewModel.getSliderAds();
    widget.viewModel.getSectionAds("ads");
    widget.viewModel.getOrdinaryAds();
    widget.viewModel.getMostWantedAds();
  }
}
