import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/profile/my_favorites_screen.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
                    fontFamily: "Almarai",
                  ),
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: (index) {
                    setState(() {});
                  },
                  tabs: [
                    Tab(
                      text: "Products",
                    ),
                    Tab(
                      text: "ADS",
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0) + EdgeInsets.only(bottom: 10),
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            removeTop: true,
            child: DynamicHeightGridView(
              itemCount: 8,
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: NeverScrollableScrollPhysics(),
              builder: (BuildContext context, int index) {
                return FavoriteItem();
              },
            ),
          ),
        ),
      ),
    );
  }
}
