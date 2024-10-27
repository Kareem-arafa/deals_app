import 'package:dealz/data/models/commercial_store_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/stores/my_store_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyStoresScreen extends StatelessWidget {
  const MyStoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _MyStoresScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _MyStoresScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;

  const _MyStoresScreenContent({super.key, required this.viewModel});

  @override
  State<_MyStoresScreenContent> createState() => _MyStoresScreenState();
}

class _MyStoresScreenState extends State<_MyStoresScreenContent> {
  int selectedBody = 0;

  @override
  void initState() {
    super.initState();
    widget.viewModel.getCommercialStores(true);
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
            Translations.of(context).text("MyStoresScreenTitle"),
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
                    setState(() {
                      selectedBody = index;
                    });
                    if (index == 0) {
                      widget.viewModel.getCommercialStores(true);
                    } else {
                      widget.viewModel.getCommercialStores(false);
                    }
                  },
                  tabs: [
                    Tab(
                      text: Translations.of(context).text("MyStoresScreenActive"),
                    ),
                    Tab(
                      text: Translations.of(context).text("MyStoresScreenInActive"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: widget.viewModel.getCommercialStoresReport.status == ActionStatus.running
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
                  itemCount: widget.viewModel.commercialStore.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  itemBuilder: (_, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyStoreDetailsScreen(storeId: widget.viewModel.commercialStore[index].id!),
                          ),
                        );
                      },
                      child: MyStoreItem(
                        selectedBody: selectedBody,
                        store: widget.viewModel.commercialStore[index],
                      ),
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

class MyStoreItem extends StatelessWidget {
  const MyStoreItem({
    super.key,
    required this.selectedBody,
    required this.store,
  });

  final int selectedBody;
  final CommercialStoreModel store;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(store.logo ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  new Text(
                    store.getName(Translations.of(context).currentLanguage),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new Text(
                    store.getDescription(Translations.of(context).currentLanguage),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  /*  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          selectedBody == 0 ? "Deactivate" : "Activate",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
