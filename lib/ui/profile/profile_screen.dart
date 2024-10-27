import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/social_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/auth_viewmodel.dart';
import 'package:dealz/ui/auth/login_screen.dart';
import 'package:dealz/ui/cart/addresses/my_addresses_screen.dart';
import 'package:dealz/ui/chat/chat_screen.dart';
import 'package:dealz/ui/profile/about_us_screen.dart';
import 'package:dealz/ui/profile/edit_user_profile_screen.dart';
import 'package:dealz/ui/profile/following_screen.dart';
import 'package:dealz/ui/profile/last_seen_screen.dart';
import 'package:dealz/ui/profile/my_ads_screen.dart';
import 'package:dealz/ui/profile/my_favorites_screen.dart';
import 'package:dealz/ui/profile/my_orders/my_order_screen.dart';
import 'package:dealz/ui/profile/my_stores_screen.dart';
import 'package:dealz/ui/profile/profile_statistics_screen.dart';
import 'package:dealz/ui/profile/return_policity_screen.dart';
import 'package:dealz/ui/profile/setting_screen.dart';
import 'package:dealz/ui/profile/terms_and_conditions_screen.dart';
import 'package:dealz/ui/settings/settings_option.dart';
import 'package:dealz/ui/trend/trend_ad_store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  final SettingsOptions options;
  final ValueChanged<SettingsOptions> onOptionsChanged;

  const ProfileScreen({super.key, required this.options, required this.onOptionsChanged});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      distinct: true,
      converter: (store) => AuthViewModel.fromStore(store),
      builder: (_, viewModel) => _ProfileScreenContent(
        authViewModel: viewModel,
        options: options,
        onOptionsChanged: onOptionsChanged,
      ),
    );
  }
}

class _ProfileScreenContent extends StatefulWidget {
  final AuthViewModel authViewModel;
  final SettingsOptions options;
  final ValueChanged<SettingsOptions> onOptionsChanged;

  const _ProfileScreenContent(
      {super.key, required this.authViewModel, required this.options, required this.onOptionsChanged});

  @override
  State<_ProfileScreenContent> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileScreenContent> {
  @override
  void initState() {
    super.initState();
    this.widget.authViewModel.getSocialMedia();
  }

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _ProfileScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.authViewModel.logoutActionReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage(Translations.of(context).text("profileScreenLogoutMessage"));
          progressDialog!.show();
        }
      } else if (this.widget.authViewModel.logoutActionReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        if(this.widget.authViewModel.logoutActionReport.msg == "Unauthenticated."){
          showCreateUserBottomSheet(context);
        }
       // showToast("${this.widget.authViewModel.logoutActionReport.msg}");
        this.widget.authViewModel.logoutActionReport.status = null;
      } else if (this.widget.authViewModel.logoutActionReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.authViewModel.logoutActionReport.status = null;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.authViewModel.logoutActionReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          Translations.of(context).text("profileScreenTitle"),
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        /*leading: IconButton(
          onPressed: () {
            //  Navigator.pop(context);
          },
          icon: Image.asset(
            Assets.images.backArrow.path,
            height: 18,
          ),
        ),*/
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Image.asset(
              Assets.images.cart.path,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Image.asset(
                Assets.images.onlineChat.path,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (this.widget.authViewModel.user != null) ...[
                    Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xffcfcfcf),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Color(0x7fdadada), offset: Offset(0, 6), blurRadius: 12, spreadRadius: -1)
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProfileScreen(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      widget.authViewModel.user?.image != null
                                          ? new Container(
                                              width: 76,
                                              height: 76,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff21b9d8),
                                                image: DecorationImage(
                                                  image: NetworkImage(widget.authViewModel.user?.image ?? ""),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              width: 76,
                                              height: 76,
                                            ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                new Text(
                                                  this.widget.authViewModel.user?.name ?? "",
                                                  style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Image.asset(
                                                      Assets.images.pen.path,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            new Text(
                                              Translations.of(context).text("profileScreenChangeProfilePictureLabel"),
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  Assets.images.phone.path,
                                                  color: Colors.black,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Directionality(
                                                  textDirection: TextDirection.ltr,
                                                  child: Text(
                                                    "+${this.widget.authViewModel.user?.phone ?? ""}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: -20,
                              left: -14,
                              child: Image.asset(
                                Assets.images.profileBg.path,
                                height: 150,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                  if (this.widget.authViewModel.user != null) ...[
                    Row(
                      children: [
                        profileContainer(
                            Assets.images.fav.path, Translations.of(context).text("profileScreenFavoriteLabel"), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MyFavoritesScreen(),
                            ),
                          );
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        profileContainer(
                            Assets.images.myAds.path, Translations.of(context).text("profileScreenMyAddsLabel"), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MyAdsScreen(),
                            ),
                          );
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        profileContainer(
                            Assets.images.lastSeen.path, Translations.of(context).text("profileScreenLastSeenLabel"),
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LastSeenScreen(),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        profileContainer(
                            Assets.images.statistics.path, Translations.of(context).text("profileScreenStaticsLabel"),
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProfileStatisticsScreen(),
                            ),
                          );
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        profileContainer(
                            Assets.images.orders.path, Translations.of(context).text("profileScreenMyOrdersLabel"), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MyOrderScreen(),
                            ),
                          );
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        profileContainer(
                            Assets.images.myStores.path, Translations.of(context).text("profileScreenMyStoresLabel"),
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MyStoresScreen(),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            if (this.widget.authViewModel.user != null)
              profileItem(Assets.images.person.path, Translations.of(context).text("profileScreenFollowingLabel"), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FollowingScreen(),
                  ),
                );
              }),
            profileItem(Assets.images.setting.path, Translations.of(context).text("settingScreenTitle"), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(
                    options: widget.options,
                    onOptionsChanged: widget.onOptionsChanged,
                  ),
                ),
              );
            }),
            /* profileItem(
                Assets.images.myproducts.path, Translations.of(context).text("profileScreenMyProductsLabel"), () {}),*/
            /* profileItem(Assets.images.subscribtion.path,
                Translations.of(context).text("profileScreenSubscriptionsLabel"), () {}),*/
            if (this.widget.authViewModel.user != null)
              profileItem(Assets.images.address.path, Translations.of(context).text("profileScreenMyAddressesLabel"),
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddressesScreen(),
                  ),
                );
              }),
            profileItem(Assets.images.aboutUs.path, Translations.of(context).text("profileScreenAboutUsLabel"), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AboutUsScreen(),
                ),
              );
            }),
            profileItem(Assets.images.phone.path, Translations.of(context).text("profileScreenContactUsLabel"), () {},
                iconColor: Colors.black, isContact: true),
            profileItem(Assets.images.termsConditions.path,
                Translations.of(context).text("profileScreenTermsAndConditionsLabel"), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TermsAndConditionsScreen(),
                ),
              );
            }),
            /* profileItem(
                Assets.images.termsConditions.path, Translations.of(context).text("profileScreenReturnPolicyLabel"),
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReturnPolicyScreen(),
                ),
              );
            }),*/
            profileItem(
              Assets.images.joinUs.path,
              Translations.of(context).text("profileScreenJoinUsLabel"),
              () {},
            ),
            this.widget.authViewModel.user != null
                ? profileItem(Assets.images.person.path, Translations.of(context).text("profileScreenLogoutLabel"), () {
                    this.widget.authViewModel.logout();
                  }, hasNoDivider: true)
                : profileItem(Assets.images.person.path, Translations.of(context).text("loginScreenLoginButton"), () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }, hasNoDivider: true),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  profileItem(String img, String title, Function() onTap, {bool? hasNoDivider, Color? iconColor, isContact}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 12),
          child: ListTile(
            leading: Image.asset(
              img,
              height: 24,
              color: iconColor ?? null,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isContact ?? false)
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          SocialMediaModel? socialMediaModel;
                          for (var social in widget.authViewModel.socialMedia) {
                            print(social.type);
                            if (social.type == "facebook") {
                              socialMediaModel = social;
                            }
                          }
                          print(socialMediaModel?.type);
                          if (!await launchUrl(Uri.parse(socialMediaModel?.link ?? ""))) {
                            throw Exception('Could not launch');
                          }
                        },
                        child: Image.asset(
                          Assets.images.facebook.path,
                          height: 22,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () async {
                          SocialMediaModel? socialMediaModel;
                          for (var social in widget.authViewModel.socialMedia) {
                            print(social.type);
                            if (social.type == "instagram") {
                              socialMediaModel = social;
                            }
                          }
                          print(socialMediaModel?.type);
                          if (!await launchUrl(Uri.parse(socialMediaModel?.link ?? ""))) {
                            throw Exception('Could not launch');
                          }
                        },
                        child: Image.asset(
                          Assets.images.instagram.path,
                          height: 22,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () async {
                          SocialMediaModel? socialMediaModel;
                          for (var social in widget.authViewModel.socialMedia) {
                            print(social.type);
                            if (social.type == "twitter") {
                              socialMediaModel = social;
                            }
                          }
                          print(socialMediaModel?.type);
                          if (!await launchUrl(Uri.parse(socialMediaModel?.link ?? ""))) {
                            throw Exception('Could not launch');
                          }
                        },
                        child: Image.asset(
                          Assets.images.twitter.path,
                          height: 22,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () async {
                          SocialMediaModel? socialMediaModel;
                          for (var social in widget.authViewModel.socialMedia) {
                            print(social.type);
                            if (social.type == "youtube") {
                              socialMediaModel = social;
                            }
                          }
                          print(socialMediaModel?.type);
                          if (!await launchUrl(Uri.parse(socialMediaModel?.link ?? ""))) {
                            throw Exception('Could not launch');
                          }
                        },
                        child: Image.asset(
                          Assets.images.youtube.path,
                          height: 22,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () async {
                          /*SocialMediaModel? socialMediaModel;
                          for (var social in widget.authViewModel.socialMedia) {
                            print(social.type);
                            if (social.type == "youtube") {
                              socialMediaModel = social;
                            }
                          }
                          print(socialMediaModel?.type);
                          if (!await launchUrl(Uri.parse(socialMediaModel?.link ?? ""))) {
                            throw Exception('Could not launch');
                          }*/
                        },
                        child: Image.asset(
                          Assets.images.snapchatPng.path,
                          height: 22,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () async {
                          /*SocialMediaModel? socialMediaModel;
                          for (var social in widget.authViewModel.socialMedia) {
                            print(social.type);
                            if (social.type == "youtube") {
                              socialMediaModel = social;
                            }
                          }
                          print(socialMediaModel?.type);
                          if (!await launchUrl(Uri.parse(socialMediaModel?.link ?? ""))) {
                            throw Exception('Could not launch');
                          }*/
                        },
                        child: Image.asset(
                          Assets.images.tiktok.path,
                          height: 22,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            onTap: onTap,
          ),
        ),
        if (!(hasNoDivider ?? false))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Divider(
              color: Color(0xffcfcfcf),
              thickness: 1,
              height: 8,
            ),
          ),
      ],
    );
  }

  profileContainer(
    String img,
    String title,
    Function() onTap,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: new Container(
          height: 114,
          decoration: new BoxDecoration(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img,
                height: 30,
              ),
              SizedBox(
                height: 10,
              ),
              new Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
