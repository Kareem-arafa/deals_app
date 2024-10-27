import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/duration_extentions.dart';
import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/data/models/store_details_model.dart';
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

class AllProductsView extends StatelessWidget {
  final int categoryId;

  const AllProductsView({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AllProductsViewContent(
        viewModel: viewModel,
        categoryId: categoryId,
      ),
    );
  }
}

class _AllProductsViewContent extends StatefulWidget {
  final int categoryId;
  final HomeViewModel viewModel;

  const _AllProductsViewContent({super.key, required this.categoryId, required this.viewModel});

  @override
  State<_AllProductsViewContent> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<_AllProductsViewContent> {
  List<String> filters = [
    "All Filters",
    "Type",
    "Location",
    "Price",
  ];

  final _debouncer = Debouncer(milliseconds: 1000);
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getCategoryAds(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          Assets.images.backArrow.path,
                          height: 18,
                          matchTextDirection: true,
                        ),
                      ),
                     /* SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x11000000), offset: Offset(0, 0), blurRadius: 10, spreadRadius: 0),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFieldWidget(
                            type: TextFieldType.text,
                            hint: "For Rent",
                            padding: 16,
                            prefixIcon: Image.asset(
                              Assets.images.search.path,
                            ),
                            controller: search,
                            onChanged: (text) {
                              _debouncer.run(() {
                                widget.viewModel.searchInAds(widget.categoryId, text ?? "");
                              });
                              setState(() {});
                              return text;
                            },
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
                /*SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    itemCount: filters.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) {
                      return new Container(
                        height: 36,
                        decoration: new BoxDecoration(
                          color: index == 0 ? Theme.of(context).primaryColor : Colors.white,
                          border: Border.all(
                            color: index == 0 ? Colors.transparent : Color(0xffeaeaea),
                            width: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                filters[index],
                                style: TextStyle(
                                  color: index == 0 ? Colors.white : Color(0xff717171),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (index != 0)
                                SizedBox(
                                  width: 12,
                                ),
                              if (index != 0)
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => SizedBox(
                      width: 5,
                    ),
                  ),
                ),*/
                SizedBox(
                  height: 22,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                            text: "${widget.viewModel.categoriesAds.length} ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            )),
                        new TextSpan(
                          text: "Results",
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
                  height: 25,
                ),
                this.widget.viewModel.getCategoryAdsReport.status == ActionStatus.running
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
                          itemCount: this.widget.viewModel.categoriesAds.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (_, int index) {
                            final ad = this.widget.viewModel.categoriesAds[index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AdsDetailsByIdView(
                                      adsId: ad.id!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
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
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                (ad.images?.isEmpty ?? true) ? "" : ad.images?.first.image ?? ""),
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
                                              "Sama Broker",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xffb3b3b3),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            new Text(
                                              ad.getTitle(Translations.of(context).currentLanguage) ?? "",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            RichText(
                                              text: new TextSpan(
                                                children: [
                                                  new TextSpan(
                                                      text: ad.price.toString() ?? "",
                                                      style: TextStyle(
                                                        color: Theme.of(context).primaryColor,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800,
                                                      )),
                                                  new TextSpan(
                                                    text: "kwd",
                                                    style: TextStyle(
                                                      color: Theme.of(context).primaryColor,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            new Text(
                                              "5m ago",
                                              style: TextStyle(
                                                color: Color(0xffa1a1a1),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
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
                            height: 10,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
