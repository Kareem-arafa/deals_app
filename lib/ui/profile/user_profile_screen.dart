import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/title_with_viewAll.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/data/models/store_details_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/ads_details_by_id_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/ads/ads_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _UserProfileScreenContent(
        viewModel: viewModel,
        user: user,
      ),
    );
  }
}

class _UserProfileScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final UserModel user;

  const _UserProfileScreenContent({required this.viewModel, required this.user});

  @override
  State<_UserProfileScreenContent> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<_UserProfileScreenContent> {
  @override
  void initState() {
    super.initState();
    // this.widget.viewModel.getUserProfile(widget.user);
    this.widget.viewModel.getUserAds(widget.user.id!);
  }

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _UserProfileScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.followUserReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.followUserReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.followUserReport.msg}");
        this.widget.viewModel.followUserReport.status = null;
      } else if (this.widget.viewModel.followUserReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.viewModel.followUserReport.status = null;
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.followUserReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return /*this.widget.viewModel.getUserProfileReport.status == ActionStatus.running
        ? Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CupertinoActivityIndicator(
                animating: true, // Control animation
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        : */Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              title: Text(
                widget.user.name ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 57,
                              height: 57,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.user.image ?? ""),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.user.phone ?? "",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if ((widget.user.id ?? 0) != (widget.viewModel.user?.id ?? 0))
                              InkWell(
                                onTap: () {
                                  if (widget.user.isFollowing ?? false) {
                                    widget.viewModel.unfollowUser(widget.user);
                                  } else {
                                    widget.viewModel.followUser(widget.user);
                                  }
                                },
                                child: Text(
                                  (widget.user.isFollowing ?? false)
                                      ? Translations.of(context).text("adsDetailsAddUnfollowLabel")
                                      : Translations.of(context).text("adsDetailsAddFollowLabel"),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TitleWithViewAll(
                          title: Translations.of(context).text("allAds"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        this.widget.viewModel.getUserAdsReport.status == ActionStatus.running
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
                                  itemCount: this.widget.viewModel.userAds.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, int index) {
                                    final MyAdsModel ads = this.widget.viewModel.userAds[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => AdsDetailsByIdView(
                                              adsId: ads.id!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 117,
                                                height: 102,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(16),
                                                  image: DecorationImage(
                                                    image: NetworkImage((ads.images?.isEmpty ?? true)
                                                        ? ""
                                                        : ads.images!.first.image ?? ""),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 18,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    new Text(
                                                      ads.getTitle(Translations.of(context).currentLanguage),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Align(
                                                      alignment: AlignmentDirectional.centerEnd,
                                                      child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Theme.of(context).primaryColor,
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            "View Details",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.w500,
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
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => SizedBox(
                                    height: 15,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
