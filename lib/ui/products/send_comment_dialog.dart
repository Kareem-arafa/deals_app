import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/comment_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SendCommentDialog extends StatelessWidget {
  final MyAdsModel content;
  final CommentModel? comment;

  const SendCommentDialog({super.key, required this.content, this.comment});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _SendMessageDialogContent(
        viewModel: viewModel,
        content: content,
        comment: comment,
      ),
    );
  }
}

class _SendMessageDialogContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final MyAdsModel content;

  final CommentModel? comment;

  const _SendMessageDialogContent({super.key, required this.viewModel, required this.content, this.comment});

  @override
  _SendMessageDialogState createState() => _SendMessageDialogState();
}

class _SendMessageDialogState extends State<_SendMessageDialogContent> {
  TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.comment != null) {
      _messageController.text = widget.comment?.comment ?? "";
    }
  }

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _SendMessageDialogContent oldWidget) {
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
        if (widget.comment != null) {
          showToast("messages updated successfully");
        } else {
          showToast("messages sent successfully");
        }
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
    return AlertDialog(
      title: Text(widget.comment != null ? 'Update Message' : 'Send Message'),
      content: TextField(
        controller: _messageController,
        decoration: InputDecoration(hintText: 'Enter your Comment'),
        maxLines: 3,
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(widget.comment != null ? 'UPDATE' : 'SEND'),
          onPressed: () {
            String message = _messageController.text.trim();
            if (message.isNotEmpty) {
              _sendComment(message);
            }
          },
        ),
      ],
    );
  }

  void _sendComment(String message) {
    if (widget.comment != null) {
      this.widget.viewModel.updateComment(widget.comment!, message);
    } else {
      this.widget.viewModel.createComment(widget.content, message);
    }
  }
}
