import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/ads_details_by_id_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/ads/ads_details_screen.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LastSeenScreen extends StatelessWidget {
  const LastSeenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _LastSeenScreenContent(
        homeViewModel: viewModel,
      ),
    );
  }
}

class _LastSeenScreenContent extends StatefulWidget {
  final HomeViewModel homeViewModel;

  const _LastSeenScreenContent({super.key, required this.homeViewModel});

  @override
  State<_LastSeenScreenContent> createState() => _LastSeenScreenState();
}

class _LastSeenScreenState extends State<_LastSeenScreenContent> {
  @override
  void initState() {
    super.initState();
    this.widget.homeViewModel.getLastSeen();
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
        centerTitle: false,
        title: Text(
          Translations.of(context).text("profileScreenLastSeenLabel"),
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: this.widget.homeViewModel.getLastSeenReport.status == ActionStatus.running
              ? Center(
                  child: CupertinoActivityIndicator(
                    animating: true, // Control animation
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${this.widget.homeViewModel.lastSeenAds.length} ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Almarai",
                            ),
                          ),
                          TextSpan(
                            text: Translations.of(context).text("lastSeenAdsLabel"),
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Almarai",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: DynamicHeightGridView(
                        itemCount: this.widget.homeViewModel.lastSeenAds.length,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        physics: NeverScrollableScrollPhysics(),
                        builder: (BuildContext context, int index) {
                          return LastSeenItem(
                            adsModel: this.widget.homeViewModel.lastSeenAds[index],
                          );
                        },
                      ),
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
}

class LastSeenItem extends StatelessWidget {
  final MyAdsModel adsModel;

  const LastSeenItem({
    super.key,
    required this.adsModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdsDetailsByIdView(
              adsId: adsModel.id!,
            ),
          ),
        );
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
              Container(
                width: double.infinity,
                height: 112,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(adsModel.images?.first.image ?? ""),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                adsModel.user?.name ?? "",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(adsModel.getTitle(Translations.of(context).currentLanguage),
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1),
              SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
