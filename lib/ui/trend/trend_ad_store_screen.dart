import 'package:dealz/data/models/create_trend_ads_model.dart';
import 'package:dealz/data/models/trend_ads_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/ads_details_by_id_screen.dart';
import 'package:dealz/ui/ads/commercial_ads_by_id.dart';
import 'package:dealz/ui/ads/create_ads/trend_add.dart';
import 'package:dealz/ui/auth/create_account/signup_with_email_screen.dart';
import 'package:dealz/ui/auth/login_screen.dart';
import 'package:dealz/ui/home/home_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/stores/store_details_secreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';

class TrendAdStoreScreen extends StatelessWidget {
  const TrendAdStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _TrendAdStoreScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _TrendAdStoreScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _TrendAdStoreScreenContent({required this.viewModel});

  @override
  State<_TrendAdStoreScreenContent> createState() => _TrendAdStoreScreenState();
}

class _TrendAdStoreScreenState extends State<_TrendAdStoreScreenContent> {
  final ScrollController _scrollController = ScrollController();

  bool isPagination = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    this.widget.viewModel.getTrendsAds(false);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
        this.widget.viewModel.getTrendsAdsReport.status != ActionStatus.running) {
      isPagination = true;
      this.widget.viewModel.getTrendsAds(true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _TrendAdStoreScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.getTrendsAdsReport.status == ActionStatus.running) {
      } else if (this.widget.viewModel.getTrendsAdsReport.status == ActionStatus.error) {
      } else if (this.widget.viewModel.getTrendsAdsReport.status == ActionStatus.complete) {
        if (!isPagination) {
          isPagination = true;
          Future.delayed(Duration(seconds: 1), () {
            this.widget.viewModel.getTrendsAds(true);
          });
        }
      } else {}
      this.widget.viewModel.getTrendsAdsReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          Translations.of(context).text("TrendingAdsTitle"),
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: this.widget.viewModel.getTrendsAdsReport.status == ActionStatus.running
          ? Center(
              child: CupertinoActivityIndicator(
                animating: true, // Control animation
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: widget.viewModel.trendsAds.isEmpty
                  ? EmptyTrendPage(
                      userModel: widget.viewModel.user,
                    )
                  : RefreshIndicator.adaptive(
                      onRefresh: _handleRefresh,
                      child: ListView.separated(
                        itemCount: this.widget.viewModel.trendsAds.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return TrendAdsPageWidget(
                            userModel: widget.viewModel.user,
                            verticalAds: widget.viewModel.trendsAds[index][trendsSize.vertical.name] ?? [],
                            smallAds: widget.viewModel.trendsAds[index][trendsSize.small.name] ?? [],
                            bigAds: widget.viewModel.trendsAds[index][trendsSize.big.name] ?? [],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    ),
            ),
    );
  }

  Future<void> _handleRefresh() async {
    isPagination = false;
    this.widget.viewModel.getTrendsAds(false);
  }
}

class VerticalTrendAdsWidget extends StatelessWidget {
  final TrendAdsModel trendAdsModel;

  const VerticalTrendAdsWidget({super.key, required this.trendAdsModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onTrendAdsClickedHandler(context, trendAdsModel);
      },
      child: Stack(
        children: [
          Container(
            height: 250,
            width: (MediaQuery.of(context).size.width - 42) / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              image: DecorationImage(
                image: NetworkImage(trendAdsModel.imageUrl ?? ""),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65,
              width: (MediaQuery.of(context).size.width - 42) / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                color: Colors.black.withOpacity(0.2),
              ),
              child: Center(
                child: Text(
                  trendAdsModel.title ?? "",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BigTrendAdsWidget extends StatelessWidget {
  final TrendAdsModel trendAdsModel;

  const BigTrendAdsWidget({super.key, required this.trendAdsModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onTrendAdsClickedHandler(context, trendAdsModel);
      },
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              image: DecorationImage(
                image: NetworkImage(trendAdsModel.imageUrl ?? ""),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                color: Colors.black.withOpacity(0.2),
              ),
              child: Center(
                child: Text(
                  trendAdsModel.title ?? "",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmallTrendAdsWidget extends StatelessWidget {
  final TrendAdsModel trendAdsModel;

  const SmallTrendAdsWidget({super.key, required this.trendAdsModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onTrendAdsClickedHandler(context, trendAdsModel);
      },
      child: Stack(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              image: DecorationImage(
                image: NetworkImage(trendAdsModel.imageUrl ?? ""),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    trendAdsModel.title ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TrendAdsPageWidget extends StatelessWidget {
  final UserModel? userModel;
  final List<TrendAdsModel> verticalAds;
  final List<TrendAdsModel> smallAds;
  final List<TrendAdsModel> bigAds;

  const TrendAdsPageWidget({
    super.key,
    required this.verticalAds,
    required this.smallAds,
    required this.bigAds,
    this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: ListView.separated(
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (verticalAds.isEmpty) {
                return EmptyVerticalWidget(
                  userModel: userModel,
                );
              } else if (verticalAds.length == 1 && index == 1) {
                return EmptyVerticalWidget(
                  userModel: userModel,
                );
              } else {
                return VerticalTrendAdsWidget(
                  trendAdsModel: verticalAds[index],
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 10,
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        bigAds.isNotEmpty
            ? Row(
                children: [
                  Expanded(
                    child: BigTrendAdsWidget(
                      trendAdsModel: bigAds[0],
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: EmptyBigWidget(
                      userModel: userModel,
                    ),
                  ),
                ],
              ),
        /*  SizedBox(
          height: 25,
        ),
        smallAds.isEmpty
            ? EmptySmallWidget(
                userModel: userModel,
              )
            : ListView.separated(
                itemCount: smallAds.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SmallTrendAdsWidget(
                    trendAdsModel: smallAds[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              )*/
      ],
    );
  }
}

class EmptyVerticalWidget extends StatelessWidget {
  final UserModel? userModel;

  const EmptyVerticalWidget({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (userModel == null) {
          showCreateUserBottomSheet(context);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text(Translations.of(context).text("TrendingAdsTitle")),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TrendAdd(
                      initialSize: trendsSize.vertical,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
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
                  Icon(
                    Icons.add_box_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EmptyBigWidget extends StatelessWidget {
  final UserModel? userModel;

  const EmptyBigWidget({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (userModel == null) {
          showCreateUserBottomSheet(context);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text(Translations.of(context).text("TrendingAdsTitle")),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TrendAdd(
                      initialSize: trendsSize.big,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
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
                  Icon(
                    Icons.add_box_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
/*
class EmptySmallWidget extends StatelessWidget {
  final UserModel? userModel;

  const EmptySmallWidget({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (userModel == null) {
          showCreateUserBottomSheet(context);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text(Translations.of(context).text("TrendingAdsTitle")),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TrendAdd(
                      initialSize: trendsSize.small,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
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
                  Icon(
                    Icons.add_box_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}*/

class EmptyTrendPage extends StatelessWidget {
  final UserModel? userModel;

  const EmptyTrendPage({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            EmptyVerticalWidget(
              userModel: userModel,
            ),
            SizedBox(
              width: 10,
            ),
            EmptyVerticalWidget(
              userModel: userModel,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: EmptyBigWidget(
              userModel: userModel,
            )),
          ],
        ),
        /*SizedBox(
          height: 25,
        ),
        EmptySmallWidget(
          userModel: userModel,
        ),*/
      ],
    );
  }
}

void showCreateUserBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                Translations.of(context).text("guestBottomSheetForLoginOrRegisterTitle"),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text(
                Translations.of(context).text("loginScreenLoginButton"),
              ),
              onTap: () {
                // Close the bottom sheet and navigate to login screen
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text(
                Translations.of(context).text("loginScreenRegisterNow"),
              ),
              onTap: () {
                // Close the bottom sheet and navigate to register screen
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupWithEmailScreen()));
              },
            ),
          ],
        ),
      );
    },
  );
}

void _onTrendAdsClickedHandler(BuildContext context, TrendAdsModel trendAdsModel) {
  if (trendAdsModel.sourceType == "store") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoreDetailsScreen(storeId: trendAdsModel.sourceId, homeType: HomeType.commercial),
      ),
    );
  } else if (trendAdsModel.sourceType == "ordinary") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdsDetailsByIdView(
          adsId: trendAdsModel.sourceId!,
        ),
      ),
    );
  } else if (trendAdsModel.sourceType == "commercial") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommercialAdsByIdScreen(
          adsId: trendAdsModel.sourceId!,
        ),
      ),
    );
  } else if (trendAdsModel.sourceType == "product") {
    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommercialAdsByIdScreen(
          adsId: trendAdsModel.sourceId!,
        ),
      ),
    );*/
  }
}
