import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ReportAdsWidget extends StatelessWidget {
  final int adsId;

  const ReportAdsWidget({required this.adsId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => FavoriteIconContent(
        viewModel: viewModel,
        adsId: adsId,
      ),
    );
  }
}

class FavoriteIconContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final int adsId;

  const FavoriteIconContent({super.key, required this.viewModel, required this.adsId});

  @override
  State<FavoriteIconContent> createState() => _FavoriteIconContentState();
}

class _FavoriteIconContentState extends State<FavoriteIconContent> {
  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant FavoriteIconContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.reportProductReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.reportProductReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.reportProductReport.msg}");
        this.widget.viewModel.reportProductReport.status = null;
      } else if (this.widget.viewModel.reportProductReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.viewModel.reportProductReport.status = null;
        showToast("Reported successfully");
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.reportProductReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.widget.viewModel.reportProduct(widget.adsId);
      },
      child: Row(
        children: [
          Text(
            Translations.of(context).text("ReportAdLabel"),
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Image.asset(
            Assets.images.flagIcon.path,
            width: 15,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
