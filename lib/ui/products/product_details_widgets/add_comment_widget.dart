import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:dealz/ui/products/send_comment_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AddCommentWidget extends StatelessWidget {
  final MyAdsModel adsModel;

  const AddCommentWidget({super.key, required this.adsModel});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _AddCommentWidgetContent(
        viewModel: viewModel,
        adsModel: adsModel,
      ),
    );
  }
}

class _AddCommentWidgetContent extends StatefulWidget {
  final MyAdsModel adsModel;
  final HomeViewModel viewModel;

  const _AddCommentWidgetContent({super.key, required this.adsModel, required this.viewModel});

  @override
  State<_AddCommentWidgetContent> createState() => _AddCommentWidgetContentState();
}

class _AddCommentWidgetContentState extends State<_AddCommentWidgetContent> {
  TextEditingController _messageController = TextEditingController();
  ProgressDialog? progressDialog;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _AddCommentWidgetContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.createCommentReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.createCommentReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.createCommentReport.msg}");
        this.widget.viewModel.createCommentReport.status = null;
      } else if (this.widget.viewModel.createCommentReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.viewModel.createCommentReport.status = null;
        _messageController.clear();
        showToast("messages sent successfully");
        Navigator.of(context).pop();
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.createCommentReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldWidget(
            type: TextFieldType.text,
            controller: _messageController,
            hint: Translations.of(context).text("adsDetailsAddCommentsLabel"),
            suffixIcon: _messageController.text.isEmpty
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      this.widget.viewModel.createComment(widget.adsModel, _messageController.text);
                    },
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
            onChanged: (text) {
              setState(() {});
              return text;
            },
          ),
        ),
      ],
    );
  }
}
