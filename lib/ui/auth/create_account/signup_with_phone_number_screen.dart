import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/auth_viewmodel.dart';
import 'package:dealz/ui/auth/create_account/verify_mobile_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SignupWithPhoneNumberView extends StatelessWidget {
  final String userName;
  final String password;
  final String email;

  const SignupWithPhoneNumberView({
    super.key,
    required this.userName,
    required this.password,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      distinct: true,
      converter: (store) => AuthViewModel.fromStore(store),
      builder: (_, viewModel) => _SignupWithPhoneNumberViewContent(
        authViewModel: viewModel,
        userName: userName,
        password: password,
        email: email,
      ),
    );
  }
}

class _SignupWithPhoneNumberViewContent extends StatefulWidget {
  final String userName;
  final String password;
  final String email;
  final AuthViewModel authViewModel;

  const _SignupWithPhoneNumberViewContent({
    required this.userName,
    required this.password,
    required this.authViewModel,
    required this.email,
  });

  @override
  State<_SignupWithPhoneNumberViewContent> createState() => _SignupWithPhoneNumberViewState();
}

class _SignupWithPhoneNumberViewState extends State<_SignupWithPhoneNumberViewContent> {
  final TextEditingController phoneController = TextEditingController();

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _SignupWithPhoneNumberViewContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.authViewModel.registerActionReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("جاري انشاء الحساب");
          progressDialog!.show();
        }
      } else if (this.widget.authViewModel.registerActionReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.authViewModel.registerActionReport.msg}");
        this.widget.authViewModel.registerActionReport.status = null;
      } else if (this.widget.authViewModel.registerActionReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VerifyMobileNumberView(
              phone: phoneController.text,
            ),
          ),
        );
        this.widget.authViewModel.registerActionReport.status = null;
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/main", (route) => false);
                },
                child: Text(
                  Translations.of(context).text("welcomeScreenSkipButtonTitle"),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
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
                    Translations.of(context).text("signupScreenTitle2"),
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
                type: TextFieldType.phone,
                hint: Translations.of(context).text("loginScreenMobileHint"),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 8,
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ButtonWidget(
                type: ButtonType.primary,
                title: Translations.of(context).text("signupScreenSignUpButton"),
                onTap: () {


                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
