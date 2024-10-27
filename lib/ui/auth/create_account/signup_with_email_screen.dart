import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/string_utils.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/auth_viewmodel.dart';
import 'package:dealz/ui/auth/create_account/verify_mobile_number_screen.dart';
import 'package:dealz/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SignupWithEmailScreen extends StatelessWidget {
  const SignupWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      distinct: true,
      converter: (store) => AuthViewModel.fromStore(store),
      builder: (_, viewModel) => _SignupWithEmailScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _SignupWithEmailScreenContent extends StatefulWidget {
  final AuthViewModel viewModel;

  const _SignupWithEmailScreenContent({required this.viewModel});

  @override
  State<_SignupWithEmailScreenContent> createState() => _SignupWithEmailScreenState();
}

class _SignupWithEmailScreenState extends State<_SignupWithEmailScreenContent> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ProgressDialog? progressDialog;

  @override
  void didUpdateWidget(covariant _SignupWithEmailScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    Future.delayed(Duration.zero, () {
      if (this.widget.viewModel.registerActionReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage("جاري انشاء الحساب");
          progressDialog!.show();
        }
      } else if (this.widget.viewModel.registerActionReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        this.widget.viewModel.registerActionReport.status = null;
      } else if (this.widget.viewModel.registerActionReport.status == ActionStatus.complete) {
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
        this.widget.viewModel.registerActionReport.status = null;
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
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
                Column(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      child: Image.asset(
                        Assets.images.logo.path,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      Translations.of(context).text("signupScreenTitle"),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Translations.of(context).text("signupScreenNameTitle"),
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
                  type: TextFieldType.text,
                  hint: Translations.of(context).text("signupScreenNameHint"),
                  controller: fullNameController,
                  prefixIcon: Icon(Icons.person_outline),
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
                        Translations.of(context).text("signupScreenEmailTitle"),
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
                  type: TextFieldType.text,
                  hint: Translations.of(context).text("signupScreenEmailHint"),
                  controller: emailController,
                  prefixIcon: Icon(Icons.mail_outline),
                  keyboardType: TextInputType.emailAddress,
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
                  hint: Translations.of(context).text("loginScreenMobileTitle"),
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
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    Translations.of(context).text("signupScreenConfirmPasswordTitle"),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  type: TextFieldType.password,
                  hint: Translations.of(context).text("signupScreenConfirmPasswordHint"),
                  controller: confirmPasswordController,
                ),
                SizedBox(
                  height: 40,
                ),
                ButtonWidget(
                  type: ButtonType.primary,
                  title: Translations.of(context).text("signupScreenSignUpButton"),
                  onTap: () {
                    if (fullNameController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty ||
                        emailController.text.isEmpty) {
                      showToast(Translations.of(context).text("signupScreenError"));
                      return;
                    }
                    if (fullNameController.text.isEmpty) {
                      showToast(Translations.of(context).text("signupScreenNameError"));
                      return;
                    }
                    if (fullNameController.text.trim().split(" ").length < 2) {
                      showToast(Translations.of(context).text("signupScreenFullNameError"));
                      return;
                    }
                    if (emailController.text.isEmpty) {
                      showToast(Translations.of(context).text("signupScreenEmailError"));
                      return;
                    }
                    if (!emailController.text.isEmail) {
                      showToast(Translations.of(context).text("signupScreenValidEmailError"));
                      return;
                    }
                    if (phoneController.text.isEmpty || phoneController.text.length < 8) {
                      showToast(Translations.of(context).text("loginScreenDataError"));
                      return;
                    }
                    if (passwordController.text.length < 8) {
                      showToast(Translations.of(context).text("loginScreenPasswordError"));
                      return;
                    }
                    if (passwordController.text != confirmPasswordController.text) {
                      showToast(Translations.of(context).text("signupScreenPasswordError"));
                      return;
                    }
                    this.widget.viewModel.register(
                          "965${phoneController.text}",
                          passwordController.text,
                          fullNameController.text,
                          emailController.text,
                        );
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Translations.of(context).text("signupScreenHaveAccount"),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: Translations.of(context).text("signupScreenLoginNow"),
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
        ),
      ),
    );
  }
}
