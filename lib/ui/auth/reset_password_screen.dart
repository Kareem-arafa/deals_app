import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/auth_viewmodel.dart';
import 'package:dealz/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../common/toast_utils.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      distinct: true,
      converter: (store) => AuthViewModel.fromStore(store),
      builder: (_, viewModel) => _ForgetPasswordScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _ForgetPasswordScreenContent extends StatefulWidget {
  final AuthViewModel viewModel;

  const _ForgetPasswordScreenContent({required this.viewModel});

  @override
  State<_ForgetPasswordScreenContent> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<_ForgetPasswordScreenContent> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _ForgetPasswordScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.resetPasswordActionReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.resetPasswordActionReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.viewModel.resetPasswordActionReport.msg}");
        this.widget.viewModel.resetPasswordActionReport.status = null;
      } else if (this.widget.viewModel.resetPasswordActionReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.viewModel.resetPasswordActionReport.status = null;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.viewModel.resetPasswordActionReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(
                        Assets.images.logo.path,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Enter Your Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFieldWidget(
                  type: TextFieldType.password,
                  hint: Translations.of(context).text("loginScreenPasswordHint"),
                  controller: passwordController,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFieldWidget(
                  type: TextFieldType.password,
                  hint: Translations.of(context).text("signupScreenConfirmPasswordHint"),
                  controller: confirmPasswordController,
                ),
              ),
              SizedBox(
                height: 120,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ButtonWidget(
                  type: ButtonType.primary,
                  title: "Reset",
                  onTap: () {
                    if (passwordController.text.length < 8) {
                      showToast(Translations.of(context).text("loginScreenPasswordError"));
                      return;
                    }
                    if (passwordController.text != confirmPasswordController.text) {
                      showToast(Translations.of(context).text("signupScreenPasswordError"));
                      return;
                    }
                    this.widget.viewModel.resetPassword(passwordController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
