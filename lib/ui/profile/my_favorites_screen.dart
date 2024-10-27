import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/ads_details_by_id_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/products/product_details_widgets/favorite_icon.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyFavoritesScreen extends StatelessWidget {
  const MyFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _MyFavoritesScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _MyFavoritesScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _MyFavoritesScreenContent({super.key, required this.viewModel});

  @override
  State<_MyFavoritesScreenContent> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<_MyFavoritesScreenContent> {
  int selectedBody = 0;

  @override
  void initState() {
    this.widget.viewModel.getWishList("store");
    super.initState();
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
            Translations.of(context).text("profileScreenFavoriteLabel"),
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
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
                    setState(() {
                      selectedBody = index;
                    });
                    if (index == 0) {
                      this.widget.viewModel.getWishList("store");
                    } else if (index == 1) {
                      this.widget.viewModel.getWishList("advertisement");
                    } else {
                      this.widget.viewModel.getWishList("product");
                    }
                  },
                  tabs: [
                    Tab(
                      text: Translations.of(context).text("followingScreenStoresLabel"),
                    ),
                    Tab(
                      text: Translations.of(context).text("mainScreenAdsLabel"),
                    ),
                    Tab(
                      text: Translations.of(context).text("favoriteScreenProfilesLabel"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0) + EdgeInsets.only(bottom: 10),
          child: this.widget.viewModel.getWishListReport.status == ActionStatus.running
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
                  child: DynamicHeightGridView(
                    itemCount: this.widget.viewModel.wishlist.length,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    builder: (BuildContext context, int index) {
                      return FavoriteItem(
                        adsModel: selectedBody == 1 ? this.widget.viewModel.wishlist[index] : null,
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final MyAdsModel? adsModel;

  const FavoriteItem({
    super.key,
    this.adsModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdsDetailsByIdView(adsId: adsModel!.id!)));
      },
      child: Container(
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
                  Container(
                    width: double.infinity,
                    height: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(adsModel?.images?.first.imageUrl ?? ""),
                      ),
                    ),
                  ),
                  /*  Positioned(
                    bottom: 0,
                    child: new Container(
                      width: 58,
                      height: 18,
                      decoration: new BoxDecoration(
                        color: Color(0xff1081ae),
                      ),
                      child: Center(
                        child: new Text(
                          "Featured",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
              /*SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text(
                    "Sama Broker",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  new Text(
                    "769590",
                    style: TextStyle(
                      color: Color(0xff7a7a7a),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),*/
              SizedBox(
                height: 4,
              ),
              Text(
                adsModel?.getTitle(Translations.of(context).currentLanguage) ?? "",
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
                    "${adsModel?.price} KWD",
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
                  /*  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "View Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
              Container(
                width: 20,
                child: FavoriteIcon(product: adsModel!),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
