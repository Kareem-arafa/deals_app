import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_screen.dart';
import 'package:dealz/ui/stores/store_details_secreen.dart';
import 'package:flutter/material.dart';

class HomeStoresWidget extends StatefulWidget {
  final List<Stores> stores;
  final HomeType homeType;
  const HomeStoresWidget({super.key, required this.stores, required this.homeType});

  @override
  State<HomeStoresWidget> createState() => _HomeStoresWidgetState();
}

class _HomeStoresWidgetState extends State<HomeStoresWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 10.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
          childAspectRatio: 150 / 125, // item height to item width ratio
        ),
        scrollDirection: Axis.horizontal, // padding around the grid
        itemCount: widget.stores.length, // total number of items
        itemBuilder: (context, index) {
          final Stores store = widget.stores[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StoreDetailsScreen(
                    store: store,
                    homeType: widget.homeType,
                  ),
                ),
              );
            },
            child: Container(
              width: 125,
              height: 150,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Color(0x7fdadada), offset: Offset(0, 5), blurRadius: 10, spreadRadius: -1)
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0) + EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        new Container(
                          height: 93,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage( Translations.of(context).currentLanguage == "ar" ? store.arabicLogo ?? "" : store.englishLogo ?? ""),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        new Text(
                         Translations.of(context).currentLanguage == "ar" ?  store.arabicName ?? "" : store.englishName ?? "",
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Image.asset(
                      Assets.images.starIconActive.path,
                      height: 26,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
