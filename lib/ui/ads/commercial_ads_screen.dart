import 'package:dealz/data/models/commercial_ad_model.dart';
import 'package:dealz/data/models/deals_section_model.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/commercial_ads_pager_view.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CommercialAdsScreen extends StatelessWidget {
  const CommercialAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _CommercialAdsScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _CommercialAdsScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _CommercialAdsScreenContent({super.key, required this.viewModel});

  @override
  State<_CommercialAdsScreenContent> createState() => _CommercialAdsScreenState();
}

class _CommercialAdsScreenState extends State<_CommercialAdsScreenContent> {
  final ScrollController _scrollController = ScrollController();

  DealsSectionModel? selectedSectionModel;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    widget.viewModel.getSectionAds("commercial");
    widget.viewModel.getCommercialAds(false);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
        this.widget.viewModel.getCommercialAdsReport.status != ActionStatus.running) {
      this.widget.viewModel.getCommercialAds(true,selectedSectionModel?.id);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 37,
              child: ListView.separated(
                itemCount: widget.viewModel.adsSections.length + 1,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedSectionModel = null;
                        });
                        widget.viewModel.getCommercialAds(false);
                      },
                      child: Container(
                        height: 37,
                        decoration: BoxDecoration(
                          color: selectedSectionModel == null ? Theme.of(context).primaryColor : Color(0xffe88b8c),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Text(
                              "All",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    final DealsSectionModel section = widget.viewModel.adsSections[index - 1];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedSectionModel = section;
                        });
                        widget.viewModel.getCommercialAds(false,section.id);
                      },
                      child: Container(
                        height: 37,
                        decoration: BoxDecoration(
                          color: selectedSectionModel == section ? Theme.of(context).primaryColor : Color(0xffe88b8c),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Text(
                              section.name(Translations.of(context).currentLanguage),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 8,
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: this.widget.viewModel.commercialAds.length.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: "Ads",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeBottom: true,
                          child: DynamicHeightGridView(
                            itemCount: widget.viewModel.commercialAds.length,
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            physics: NeverScrollableScrollPhysics(),
                            builder: (BuildContext context, int index) {
                              final CommercialAdsModel ad = widget.viewModel.commercialAds[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CommercialAdsPagerScreen(
                                        initialAds: ad,
                                        ads: widget.viewModel.commercialAds,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 169,
                                  height: 235,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          (ad.images?.isEmpty ?? true) ? "" : ad.images![0].imageUrl ?? ""),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      widget.viewModel.getCommercialAdsReport.status == ActionStatus.running
                          ? Center(
                        child: CupertinoActivityIndicator(
                          animating: true, // Control animation
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                          : SizedBox(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    widget.viewModel.getCommercialAds(false,selectedSectionModel?.id);
  }
}
