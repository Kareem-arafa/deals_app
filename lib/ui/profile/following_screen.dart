import 'package:dealz/data/models/my_store_model.dart';
import 'package:dealz/data/models/store_details_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_screen.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/profile/user_profile_screen.dart';
import 'package:dealz/ui/stores/store_details_secreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _FollowingScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _FollowingScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _FollowingScreenContent({required this.viewModel});

  @override
  State<_FollowingScreenContent> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<_FollowingScreenContent> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getFollowingsUsers();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            Translations.of(context).text("profileScreenFollowingLabel"),
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
                    fontFamily: "Almarai",
                  ),
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: (index) {
                    currentIndex = index;
                    if (index == 0) {
                      this.widget.viewModel.getFollowingsUsers();
                    } else {
                      this.widget.viewModel.getFollowingStores();
                    }
                    setState(() {});
                  },
                  tabs: [
                    Tab(
                      text: Translations.of(context).text("followingScreenProfilesLabel"),
                    ),
                    Tab(
                      text: Translations.of(context).text("followingScreenStoresLabel"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: currentIndex == 1
            ? this.widget.viewModel.getFollowingStoresReport.status == ActionStatus.running
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
                      itemCount: this.widget.viewModel.followingStore.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16) + EdgeInsets.only(bottom: 10),
                      itemBuilder: (_, int index) {
                        return FollowingStoreItem(
                          store: this.widget.viewModel.followingStore[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(
                        height: 15,
                      ),
                    ),
                  )
            : this.widget.viewModel.getFollowingsUsersReport.status == ActionStatus.running
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
                      itemCount: this.widget.viewModel.followingsUsers.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16) + EdgeInsets.only(bottom: 10),
                      itemBuilder: (_, int index) {
                        return FollowingItem(
                          user: this.widget.viewModel.followingsUsers[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(
                        height: 15,
                      ),
                    ),
                  ),
      ),
    );
  }
}

class FollowingItem extends StatelessWidget {
  final UserModel user;

  const FollowingItem({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(
              user: user,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xffd8d8d8),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Container(
                width: 62,
                height: 60,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.image ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text(
                      user.name ?? '',
                      style: TextStyle(
                        color: Color(0xff676578),
                        fontSize: 18,
                        letterSpacing: -0.09390937685966493,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Icon(
                        IconData(
                          Icons.keyboard_arrow_right_rounded.codePoint,
                          fontFamily: Icons.keyboard_arrow_right_rounded.fontFamily,
                          matchTextDirection: true,
                        ),
                        textDirection: Directionality.of(context),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FollowingStoreItem extends StatelessWidget {
  final MyStoreModel store;

  const FollowingStoreItem({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StoreDetailsScreen(storeId: store.id, homeType: HomeType.commercial),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xffd8d8d8),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Container(
                width: 62,
                height: 60,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(store.logo ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text(
                      store.name ?? '',
                      style: TextStyle(
                        color: Color(0xff676578),
                        fontSize: 18,
                        letterSpacing: -0.09390937685966493,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Icon(
                        IconData(
                          Icons.keyboard_arrow_right_rounded.codePoint,
                          fontFamily: Icons.keyboard_arrow_right_rounded.fontFamily,
                          matchTextDirection: true,
                        ),
                        textDirection: Directionality.of(context),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
