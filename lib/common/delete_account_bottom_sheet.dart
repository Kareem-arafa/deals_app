import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/auth/auth_viewmodel.dart';
import 'package:dealz/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      distinct: true,
      converter: (store) => AuthViewModel.fromStore(store),
      builder: (_, viewModel) => _DeleteAccountBottomSheetContent(
        authViewModel: viewModel,
      ),
    );
  }
}

class _DeleteAccountBottomSheetContent extends StatefulWidget {
  final AuthViewModel authViewModel;

  const _DeleteAccountBottomSheetContent({Key? key, required this.authViewModel}) : super(key: key);

  @override
  DeleteAccountBottomSheetState createState() => DeleteAccountBottomSheetState();
}

class DeleteAccountBottomSheetState extends State<_DeleteAccountBottomSheetContent> {
  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _DeleteAccountBottomSheetContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.authViewModel.deleteAccountActionReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.authViewModel.deleteAccountActionReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.authViewModel.deleteAccountActionReport.msg}");
        this.widget.authViewModel.deleteAccountActionReport.status = null;
      } else if (this.widget.authViewModel.deleteAccountActionReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.authViewModel.deleteAccountActionReport.status = null;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.authViewModel.deleteAccountActionReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 8,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Delete Account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Are you sure you want to delete your account?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16, height: 1.5),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ButtonWidget(
              onTap: () {
                this.widget.authViewModel.deleteAccount();
              },
              title: "Confirm Delete",
              type: ButtonType.primary,
            ),
            SizedBox(
              height: 25,
            ),
            ButtonWidget(
              type: ButtonType.secondary,
              onTap: () {
                Navigator.pop(context);
              },
              title: "Cancel",
              textColor: Theme.of(context).hintColor,
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
