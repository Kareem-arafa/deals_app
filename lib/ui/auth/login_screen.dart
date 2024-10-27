import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/auth_viewmodel.dart';
import 'package:dealz/ui/auth/create_account/signup_with_email_screen.dart';
import 'package:dealz/ui/auth/create_account/verify_mobile_number_screen.dart';
import 'package:dealz/ui/auth/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      distinct: true,
      converter: (store) => AuthViewModel.fromStore(store),
      builder: (_, viewModel) => _LoginScreenContent(
        authViewModel: viewModel,
      ),
    );
  }
}

class _LoginScreenContent extends StatefulWidget {
  final AuthViewModel authViewModel;

  const _LoginScreenContent({required this.authViewModel});

  @override
  State<_LoginScreenContent> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginScreenContent> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _LoginScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.authViewModel.loginActionReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage(Translations.of(context).text("loginScreenLoading"));
          progressDialog!.show();
        }
      } else if (this.widget.authViewModel.loginActionReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
       // showToast("${this.widget.authViewModel.loginActionReport.msg}");
        this.widget.authViewModel.loginActionReport.status = null;
      } else if (this.widget.authViewModel.loginActionReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.authViewModel.loginActionReport.status = null;
        if (widget.authViewModel.user?.verified ?? false) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VerifyMobileNumberView(
                phone: phoneController.text,
              ),
            ),
          );
        }
        Navigator.pushNamedAndRemoveUntil(context, "/main", (route) => false);
      } else {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
      }
      this.widget.authViewModel.loginActionReport.status = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              Container(
                width: double.infinity,
                child: Image.asset(
                  Assets.images.logo.path,
                  height: 175,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Translations.of(context).text("loginScreenTitle"),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            Translations.of(context).text("loginScreenMobileTitle"),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      type: TextFieldType.phone,
                      hint: Translations.of(context).text("loginScreenMobileHint"),
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 8,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Translations.of(context).text("loginScreenPasswordTitle"),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      type: TextFieldType.password,
                      hint: Translations.of(context).text("loginScreenPasswordHint"),
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Forget Your Password?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ButtonWidget(
                      type: ButtonType.primary,
                      title: Translations.of(context).text("loginScreenLoginButton"),
                      onTap: () {
                        if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
                          showToast(Translations.of(context).text("loginScreenDataError"));
                          return;
                        }
                        if (passwordController.text.length < 8) {
                          showToast(Translations.of(context).text("loginScreenPasswordError"));
                          return;
                        }
                        this.widget.authViewModel.login("965${phoneController.text}", passwordController.text);
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SignupWithEmailScreen(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: Translations.of(context).text("loginScreenDon'tHaveAccount"),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: Translations.of(context).text("loginScreenRegisterNow"),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
