import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/categories/category_details_screen.dart';
import 'package:dealz/ui/categories/category_item.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/home/store_product_details_screen.dart';
import 'package:dealz/ui/products/all_filters_screen.dart';
import 'package:dealz/ui/products/product_item.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AllStoresScreen extends StatelessWidget {
  final int sectionId;

  const AllStoresScreen({super.key, required this.sectionId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AllStoresScreenContent(
        viewModel: viewModel,
        sectionId: sectionId,
      ),
    );
  }
}

class _AllStoresScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final int sectionId;

  const _AllStoresScreenContent({required this.viewModel, required this.sectionId});

  @override
  State<_AllStoresScreenContent> createState() => _AllStoresScreenState();
}

class _AllStoresScreenState extends State<_AllStoresScreenContent> {
  @override
  void initState() {
    this.widget.viewModel.getSectionCategories(widget.sectionId);
    this.widget.viewModel.getSectionProductList(widget.sectionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: Text(
          Translations.of(context).text("homeScreenAllStoresLabel"),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              this.widget.viewModel.getSectionCategoriesReport.status == ActionStatus.running
                  ? Center(
                      child: CupertinoActivityIndicator(
                        animating: true, // Control animation
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : DynamicHeightGridView(
                      itemCount: this.widget.viewModel.sectionCategories.length,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      physics: NeverScrollableScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        final category = this.widget.viewModel.sectionCategories[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CategoryDetailsScreen(
                                  category: category,
                                ),
                              ),
                            );
                          },
                          child: CategoryItem(
                            category: category,
                          ),
                        );
                      },
                    ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                height: 45,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xff979797),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.images.sort.path,
                            height: 15,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          new Text("Sorting",
                              style: TextStyle(
                                color: Color(0xff010101),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ))
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: Color(0xff979797),
                      thickness: 1,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AllFiltersScreen(
                                sectionId: -1,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.images.filter.path,
                              height: 16,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            new Text("Filter",
                                style: TextStyle(
                                  color: Color(0xff010101),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                Translations.of(context).text("homeScreenAllProductsLabel"),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              this.widget.viewModel.getSectionProductListReport.status == ActionStatus.running
                  ? Center(
                      child: CupertinoActivityIndicator(
                        animating: true, // Control animation
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : DynamicHeightGridView(
                      itemCount: this.widget.viewModel.sectionProducts.length,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      physics: NeverScrollableScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        final product = this.widget.viewModel.sectionProducts[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => StoreProductDetailsScreen(),
                              ),
                            );
                          },
                          child: ProductItem(
                            product: product,
                          ),
                        );
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
