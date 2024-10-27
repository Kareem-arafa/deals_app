import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/comment_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DeleteCommentIcon extends StatelessWidget {
  final MyAdsModel adsModel;
  final CommentModel commentModel;

  const DeleteCommentIcon({super.key, required this.adsModel, required this.commentModel});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => FavoriteIconContent(
        viewModel: viewModel,
        adsModel: adsModel,
        commentModel: commentModel,
      ),
    );
  }
}

class FavoriteIconContent extends StatefulWidget {
  final MyAdsModel adsModel;
  final HomeViewModel viewModel;
  final CommentModel commentModel;

  const FavoriteIconContent({super.key, required this.adsModel, required this.viewModel, required this.commentModel});

  @override
  State<FavoriteIconContent> createState() => _FavoriteIconContentState();
}

class _FavoriteIconContentState extends State<FavoriteIconContent> {
  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant FavoriteIconContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.deleteCommentReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.deleteCommentReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.deleteCommentReport.msg}");
        this.widget.viewModel.deleteCommentReport.status = null;
      } else if (this.widget.viewModel.deleteCommentReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.viewModel.deleteCommentReport.status = null;
        showToast("Deleted successfully");
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.deleteCommentReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.widget.viewModel.deleteComment(
              widget.adsModel,
              widget.commentModel,
            );
      },
      child: Container(
        width: 30,
        height: 30,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            Assets.images.trash.path,
            width: 15,
          ),
        ),
      ),
    );
  }
}
