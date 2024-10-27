import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SendMessageDialog extends StatelessWidget {
  final int userId;

  const SendMessageDialog({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => _SendMessageDialogContent(
        viewModel: viewModel,
        userId: userId,
      ),
    );
  }
}

class _SendMessageDialogContent extends StatefulWidget {
  final HomeViewModel viewModel;
  final int userId;

  const _SendMessageDialogContent({super.key, required this.viewModel, required this.userId});

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

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _SendMessageDialogContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.sendMessageReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.sendMessageReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.sendMessageReport.msg}");
        this.widget.viewModel.sendMessageReport.status = null;
      } else if (this.widget.viewModel.sendMessageReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.viewModel.sendMessageReport.status = null;
        showToast("messages sent successfully");
        Navigator.of(context).pop();
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.sendMessageReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Send Message'),
      content: TextField(
        controller: _messageController,
        decoration: InputDecoration(hintText: 'Enter your message'),
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
          child: Text('SEND'),
          onPressed: () {
            String message = _messageController.text.trim();
            if (message.isNotEmpty) {
              _sendMessage(message);
            }
          },
        ),
      ],
    );
  }

  void _sendMessage(String message) {
    this.widget.viewModel.sendMessage(widget.userId, message);
  }
}
