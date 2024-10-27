import 'package:dealz/data/models/store_product_model.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/stores/my_store_details_screen.dart';
import 'package:dealz/ui/stores/store_product_details_screeen.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AllProductsScreen extends StatelessWidget {
  final int storeId;

  const AllProductsScreen({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AllProductsScreenContent(
        viewModel: viewModel,
        storeId: storeId,
      ),
    );
  }
}

class _AllProductsScreenContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final int storeId;

  const _AllProductsScreenContent({required this.viewModel, required this.storeId});

  @override
  State<_AllProductsScreenContent> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<_AllProductsScreenContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    this.widget.viewModel.getStoreProducts(widget.storeId, false);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
        this.widget.viewModel.getStoreProductsReport.status != ActionStatus.running) {
      this.widget.viewModel.getStoreProducts(widget.storeId, true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: DynamicHeightGridView(
              controller: _scrollController,
              itemCount: this.widget.viewModel.storeProducts.length,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              builder: (BuildContext context, int index) {
                final StoreProductModel product = this.widget.viewModel.storeProducts[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyStoreProductDetailsScreen(
                          product: product,
                          storeId: widget.storeId,
                        ),
                      ),
                    );
                  },
                  child: AllProductItem(
                    product: product,
                  ),
                );
              },
            ),
          ),
          if (this.widget.viewModel.getStoreProductsReport.status == ActionStatus.running)
            Center(
              child: CupertinoActivityIndicator(
                animating: true, // Control animation
                color: Theme.of(context).primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
