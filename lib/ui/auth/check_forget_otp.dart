import 'package:dealz/common/progress_dialog.dart';
import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/auth/auth_viewmodel.dart';
import 'package:dealz/ui/auth/create_account/pin_code_fields.dart';
import 'package:dealz/ui/auth/login_screen.dart';
import 'package:dealz/ui/auth/reset_password_screen.dart';
import 'package:dealz/ui/main_bottom_navigation/main_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CheckForgetOTP extends StatelessWidget {
  final String phone;

  const CheckForgetOTP({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      distinct: true,
      converter: (store) => AuthViewModel.fromStore(store),
      builder: (_, viewModel) => _VerifyMobileNumberViewContent(
        authViewModel: viewModel,
        phone: phone,
      ),
    );
  }
}

class _VerifyMobileNumberViewContent extends StatefulWidget {
  final String phone;
  final AuthViewModel authViewModel;

  const _VerifyMobileNumberViewContent({super.key, required this.phone, required this.authViewModel});

  @override
  State<_VerifyMobileNumberViewContent> createState() => _VerifyMobileNumberViewState();
}

class _VerifyMobileNumberViewState extends State<_VerifyMobileNumberViewContent> {
  ProgressDialog? progressDialog;

  CountdownController timerController = CountdownController(
    autoStart: true,
  );

  bool timerFinished = false;

  @override
  void didUpdateWidget(covariant _VerifyMobileNumberViewContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {
      if (this.widget.authViewModel.checkOTPActionReport.status == ActionStatus.running) {
        if (progressDialog == null) progressDialog = new ProgressDialog(context);
        if (!progressDialog!.isShowing()) {
          progressDialog!.setMessage(Translations.of(context).text('verificationScreenLoading'));
          progressDialog!.show();
        }
      } else if (this.widget.authViewModel.checkOTPActionReport.status == ActionStatus.error) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        showToast("${this.widget.authViewModel.checkOTPActionReport.msg}");
        this.widget.authViewModel.checkOTPActionReport.status = null;
      } else if (this.widget.authViewModel.checkOTPActionReport.status == ActionStatus.complete) {
        if (progressDialog != null && progressDialog!.isShowing()) {
          progressDialog!.hide();
          progressDialog = null;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
        this.widget.authViewModel.checkOTPActionReport.status = null;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                Assets.images.backArrow.path,
                height: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      Assets.images.logo.path,
                      height: 52,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      Translations.of(context).text("verificationScreenTitle"),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      '${Translations.of(context).text("verificationScreenSubTitle")} +${this.widget.phone}',
                      style: TextStyle(
                        color: Color(0xff858585),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: PinCodeFields(
                      onCompleted: (newOTP) {
                        this.widget.authViewModel.checkOTP(
                              this.widget.phone,
                              newOTP,
                            );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  timerFinished
                      ? InkWell(
                          onTap: () {
                            timerFinished = false;
                            setState(() {});
                            timerController.restart();
                            this.widget.authViewModel.forgetPassword("${widget.phone}");
                          },
                          child: Text(
                            Translations.of(context).text("resendOTPLabel"),
                            style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                          ),
                        )
                      : Countdown(
                          seconds: 120,
                          build: (BuildContext context, double time) => Text(
                            "${Translations.of(context).text("resendOTPMessageLabel")}00:${time.toInt().toString()}",
                            style: TextStyle(fontSize: 16),
                          ),
                          interval: Duration(milliseconds: 100),
                          onFinished: () {
                            setState(() {
                              timerFinished = true;
                            });
                          },
                          controller: timerController,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
