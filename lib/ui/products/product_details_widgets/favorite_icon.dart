import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FavoriteIcon extends StatelessWidget {
  final MyAdsModel product;

  const FavoriteIcon({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => FavoriteIconContent(
        viewModel: viewModel,
        product: product,
      ),
    );
  }
}

class FavoriteIconContent extends StatefulWidget {
  final MyAdsModel product;
  final HomeViewModel viewModel;

  const FavoriteIconContent({super.key, required this.product, required this.viewModel});

  @override
  State<FavoriteIconContent> createState() => _FavoriteIconContentState();
}

class _FavoriteIconContentState extends State<FavoriteIconContent> {
  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant FavoriteIconContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.addWishListReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.addWishListReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.addWishListReport.msg}");
        this.widget.viewModel.addWishListReport.status = null;
      } else if (this.widget.viewModel.addWishListReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.viewModel.addWishListReport.status = null;
        if ((widget.product.inWishlist ?? false)) {
          showToast("item add to wishlist successfully");
        } else {
          showToast("item remove from wishlist successfully");
        }
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.addWishListReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if ((widget.product.inWishlist ?? false)) {
          this.widget.viewModel.removeWishList("advertisement", widget.product);
        } else {
          this.widget.viewModel.addWishList("advertisement", widget.product);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Icon(
          (widget.product.inWishlist ?? false) ? Icons.favorite : Icons.favorite_border_outlined,
          color: (widget.product.inWishlist ?? false) ? Colors.red : null,
        ),
      ),
    );
  }
}
