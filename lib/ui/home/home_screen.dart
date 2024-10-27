import 'package:dealz/common/title_with_viewAll.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/ads_slider.dart';
import 'package:dealz/ui/home/all_commercial_section_screen.dart';
import 'package:dealz/ui/home/all_section_screen.dart';
import 'package:dealz/ui/home/home_category_widget.dart';
import 'package:dealz/ui/home/home_stores_widget.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/home/new_home_categories_widget.dart';
import 'package:dealz/ui/products/product_list.dart';
import 'package:dealz/ui/trend/main_trend_ads_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum HomeType {
  deals,
  commercial,
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _HomeScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _HomeScreenContent({required this.viewModel});

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  HomeType homeType = HomeType.deals;

  @override
  void initState() {
    this.widget.viewModel.getHomeData(HomeType.deals.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: false,
          title: Row(
            children: [
              Image.asset(
                Assets.images.notification.path,
                height: 30,
              ),
              SizedBox(
                width: 18,
              ),
              RichText(
                text: new TextSpan(
                  children: [
                    new TextSpan(
                      text: Translations.of(context).text("homeScreenWelcomeLabel"),
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        color: Color(0xff000000),
                        fontSize: 24,
                      ),
                    ),
                    new TextSpan(
                      text: this.widget.viewModel.user?.name?.split(" ").first ??
                          Translations.of(context).text("homeScreenGuestLabel"),
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        color: Color(0xff000000),
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          actions: [
            Row(
              children: [
                widget.viewModel.user?.image != null
                    ? new Container(
                        width: 45,
                        height: 45,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.viewModel.user?.image ?? ""),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  width: 14,
                ),
                Image.asset(
                  Assets.images.cart.path,
                  height: 30,
                ),
                SizedBox(
                  width: 14,
                ),
              ],
            ),
          ],
          bottom: PreferredSize(
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
                    fontFamily: 'Almarai',
                  ),
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: (index) {
                    if (index == 0) {
                      setState(() {
                        homeType = HomeType.deals;
                      });
                      this.widget.viewModel.getHomeData(HomeType.deals.name);
                    } else {
                      setState(() {
                        homeType = HomeType.commercial;
                      });
                      this.widget.viewModel.getHomeData(HomeType.commercial.name);
                    }
                  },
                  tabs: [
                    Tab(
                      text: Translations.of(context).text("homeScreenDealsStoresLabel"),
                    ),
                    Tab(
                      text: Translations.of(context).text("homeScreenCommercialStoresLabel"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: this.widget.viewModel.getHomeDataReport.status == ActionStatus.running
            ? Center(
                child: CupertinoActivityIndicator(
                  animating: true, // Control animation
                  color: Theme.of(context).primaryColor,
                ),
              )
            : SafeArea(
                child: RefreshIndicator.adaptive(
                  onRefresh: _handleRefresh,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              AdsSlider(
                                height: 116,
                                sliders: this.widget.viewModel.homeData?.sliders ?? [],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              homeType == HomeType.deals
                                  ? TitleWithViewAll(
                                      title: Translations.of(context).text("NewHomeMarketLabel"),
                                      onTap: () {},
                                    )
                                  : TitleWithViewAll(
                                      title: Translations.of(context).text("mainScreenStoresLabel"),
                                      onTap: () {},
                                    ),
                            ],
                          ),
                        ),
                        homeType == HomeType.deals
                            ? NewHomeCategoriesWidget()
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: HomeStoresWidget(
                                  stores: this.widget.viewModel.homeData?.stores ?? [],
                                  homeType: homeType,
                                ),
                              ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TitleWithViewAll(
                            title: Translations.of(context).text("homeScreenSuggestionsTitleLabel"),
                            onTap: () {},
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProductList(
                          product: this.widget.viewModel.homeData?.suggestionsSlider ?? [],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TitleWithViewAll(
                            title: Translations.of(context).text("homeScreenRecentlyAddedLabel"),
                            onTap: () {},
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProductList(
                          product: this.widget.viewModel.homeData?.recentlyAdded ?? [],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: TrendItem(
                            125,
                            hasTitle: false,
                            hasNoOpacity: true,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        homeType == HomeType.deals
                            ? SizedBox()
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: TitleWithViewAll(
                                      title: Translations.of(context).text("homeScreenSectionsLabel"),
                                      onTap: () {
                                        if (homeType == HomeType.deals) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => AllSectionScreen(
                                                sections: this.widget.viewModel.homeData?.sections ?? [],
                                              ),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => AllCommercialSectionScreen(
                                                sections: this.widget.viewModel.homeData?.sections ?? [],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  HomeCategoryWidget(
                                    sections: this.widget.viewModel.homeData?.sections ?? [],
                                  ),
                                ],
                              ),
                        homeType == HomeType.deals
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: TitleWithViewAll(
                                      title: Translations.of(context).text("homeScreenRecentlyAddedLabel"),
                                      onTap: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ProductList(
                                    product: this.widget.viewModel.homeData?.recentlyAdded ?? [],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: TitleWithViewAll(
                                      title: Translations.of(context).text("homeScreenSuggestionsTitleLabel"),
                                      onTap: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ProductList(
                                    product: this.widget.viewModel.homeData?.suggestionsSlider ?? [],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    this.widget.viewModel.getHomeData(homeType.name);
  }
}
