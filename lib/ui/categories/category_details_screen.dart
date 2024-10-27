import 'package:dealz/common/custom_button.dart';
import 'package:dealz/data/models/category_model.dart';
import 'package:dealz/data/models/filter_and_sort_model.dart';
import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/ads/ads_details_by_id_screen.dart';
import 'package:dealz/ui/ads/ads_item_widget.dart';
import 'package:dealz/ui/categories/category_item.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/products/all_filters_screen.dart';
import 'package:dealz/ui/products/all_products_screen.dart';
import 'package:dealz/ui/products/product_item.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final CategoryModel category;
  final bool fromAds;

  const CategoryDetailsScreen({
    super.key,
    required this.category,
    this.fromAds = false,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _CategoryDetailsScreenContent(
        viewModel: viewModel,
        category: category,
        fromAds: fromAds,
      ),
    );
  }
}

class _CategoryDetailsScreenContent extends StatefulWidget {
  final CategoryModel category;
  final HomeViewModel viewModel;

  final bool fromAds;

  const _CategoryDetailsScreenContent({
    required this.category,
    required this.viewModel,
    required this.fromAds,
  });

  @override
  State<_CategoryDetailsScreenContent> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<_CategoryDetailsScreenContent> {
  @override
  void initState() {
    super.initState();
    this.widget.viewModel.getSectionCategories(widget.category.id!);
    if (!this.widget.fromAds) {
      this.widget.viewModel.getCategoryProductList(this.widget.category.id!);
    } else {
      widget.viewModel.syncSortFilterData(SortAndFilterModel());
      this.widget.viewModel.getAdsBySection(this.widget.category.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          widget.category.name(Translations.of(context).currentLanguage),
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
                  : Container(
                      height: 255,
                      child: GridView.builder(
                          itemCount: this.widget.viewModel.sectionCategories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final category = this.widget.viewModel.sectionCategories[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AllProductsView(
                                      categoryId: category.id!,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  CategoryItem(
                                    category: category,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            );
                          }),
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
                      child: InkWell(
                        onTap: () {
                          _showSortBottomSheet(context, (sortName, sortPrice) {
                            final SortAndFilterModel? filterData = widget.viewModel.sortAndFilterModel?.copyWith();
                            SortAndFilterModel newFilterData;
                            if (filterData == null) {
                              newFilterData = SortAndFilterModel(
                                sortPrice: sortPrice,
                                sortName: sortName,
                              );
                            } else {
                              newFilterData = filterData.copyWith(
                                sortName: sortName,
                                sortPrice: sortPrice,
                              );
                            }
                            this.widget.viewModel.syncSortFilterData(newFilterData);
                            this.widget.viewModel.getAdsBySection(this.widget.category.id!);
                            Navigator.pop(context);
                          });
                        },
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
                            Text(
                              Translations.of(context).text("sortLabel"),
                              style: TextStyle(
                                color: Color(0xff010101),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
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
                                sectionId: this.widget.category.id!,
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
                            Text(Translations.of(context).text("filterLabel"),
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
              this.widget.viewModel.getCategoryProductListReport.status == ActionStatus.running
                  ? Center(
                      child: CupertinoActivityIndicator(
                        animating: true, // Control animation
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : DynamicHeightGridView(
                      itemCount: widget.fromAds
                          ? this.widget.viewModel.adsBySection.length
                          : this.widget.viewModel.categoryProducts.length,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      physics: NeverScrollableScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        if (widget.fromAds) {
                          MyAdsModel product = this.widget.viewModel.adsBySection[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AdsDetailsByIdView(
                                    adsId: product.id!,
                                  ),
                                ),
                              );
                            },
                            child: AdsItemWidget(
                              ads: product,
                              isSimilar: true,
                            ),
                          );
                        } else {
                          HomeProduct product = this.widget.viewModel.categoryProducts[index];
                          return InkWell(
                            onTap: () {},
                            child: ProductItem(
                              product: product,
                            ),
                          );
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }

  void _showSortBottomSheet(BuildContext context, Function(sortType?, sortType?) onTap) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SortOptionsScreen(onTap: onTap);
      },
    );
  }
}

class SortOptionsScreen extends StatefulWidget {
  final Function(sortType?, sortType?) onTap;

  const SortOptionsScreen({super.key, required this.onTap});

  @override
  State<SortOptionsScreen> createState() => _SortOptionsScreenState();
}

class _SortOptionsScreenState extends State<SortOptionsScreen> {
  sortType? _selectedSortPriceType;
  sortType? _selectedSortNameType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          RadioListTile<sortType>(
            title: const Text('High Price To Low'),
            value: sortType.high,
            groupValue: _selectedSortPriceType,
            onChanged: (sortType? value) {
              setState(() {
                _selectedSortPriceType = value;
              });
            },
          ),
          RadioListTile<sortType>(
            title: const Text('Low Price To High'),
            value: sortType.low,
            groupValue: _selectedSortPriceType,
            onChanged: (sortType? value) {
              setState(() {
                _selectedSortPriceType = value;
              });
            },
          ),
          SizedBox(
            height: 25,
          ),
          Divider(),
          SizedBox(
            height: 25,
          ),
          RadioListTile<sortType>(
            title: const Text('A To Z'),
            value: sortType.low,
            groupValue: _selectedSortNameType,
            onChanged: (sortType? value) {
              setState(() {
                _selectedSortNameType = value;
              });
            },
          ),
          RadioListTile<sortType>(
            title: const Text('Z To A'),
            value: sortType.high,
            groupValue: _selectedSortNameType,
            onChanged: (sortType? value) {
              setState(() {
                _selectedSortNameType = value;
              });
            },
          ),
          Spacer(),
          ButtonWidget(
            type: ButtonType.primary,
            onTap: () {
              widget.onTap(_selectedSortNameType, _selectedSortPriceType);
            },
            title: "Apply",
          )
        ],
      ),
    );
  }
}
