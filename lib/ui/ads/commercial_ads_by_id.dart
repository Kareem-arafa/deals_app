import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/commertial_ad_details_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CommercialAdsByIdScreen extends StatelessWidget {
  final int adsId;

  const CommercialAdsByIdScreen({super.key, required this.adsId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _CommercialAdsByIdScreenContent(
        viewModel: viewModel,
        adsId: adsId,
      ),
    );
  }
}

class _CommercialAdsByIdScreenContent extends StatefulWidget {
  final int adsId;
  final HomeViewModel viewModel;

  const _CommercialAdsByIdScreenContent({super.key, required this.adsId, required this.viewModel});

  @override
  _CommercialAdsPagerScreenState createState() => _CommercialAdsPagerScreenState();
}

class _CommercialAdsPagerScreenState extends State<_CommercialAdsByIdScreenContent> {
  @override
  void initState() {
    this.widget.viewModel.getAdById(widget.adsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.widget.viewModel.getAdByIdReport.status == ActionStatus.running
          ? Center(
              child: CupertinoActivityIndicator(
                animating: true, // Control animation
                color: Theme.of(context).primaryColor,
              ),
            )
          : CommertialAdsDetailsScreen(
              myAdsModel: widget.viewModel.singleAd!,
            ),
    );
  }
}
