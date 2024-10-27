import 'package:dealz/data/models/social_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/redux/auth/auth_actions.dart';
import 'package:redux/redux.dart';

class AuthViewModel {
  final UserModel? user;
  final int? userId;
  final List<SocialMediaModel> socialMedia;

  final Function(String, String) login;
  final Function(String, String, String, String) register;
  final Function(String, String) verify;
  final Function(int) sendOTP;
  final Function() logout;
  final Function(UserModel) setUser;
  final Function() getSocialMedia;
  final Function(UserModel) editProfile;
  final Function() deleteAccount;
  final Function(String) forgetPassword;
  final Function(String, String) checkOTP;
  final Function(String) resetPassword;
  final Function(String) resendOTP;
  final Function() getMyProfile;

  final ActionReport loginActionReport;
  final ActionReport registerActionReport;
  final ActionReport verifyActionReport;
  final ActionReport resendOTPActionReport;
  final ActionReport getSocialMediaActionReport;
  final ActionReport logoutActionReport;
  final ActionReport editProfileActionReport;
  final ActionReport deleteAccountActionReport;
  final ActionReport forgetPasswordActionReport;
  final ActionReport checkOTPActionReport;
  final ActionReport resetPasswordActionReport;

  AuthViewModel({
    this.user,
    this.userId,
    required this.login,
    required this.logout,
    required this.register,
    required this.verify,
    required this.sendOTP,
    required this.loginActionReport,
    required this.registerActionReport,
    required this.verifyActionReport,
    required this.resendOTPActionReport,
    required this.setUser,
    required this.socialMedia,
    required this.getSocialMediaActionReport,
    required this.getSocialMedia,
    required this.logoutActionReport,
    required this.editProfile,
    required this.editProfileActionReport,
    required this.deleteAccount,
    required this.deleteAccountActionReport,
    required this.checkOTP,
    required this.checkOTPActionReport,
    required this.forgetPassword,
    required this.forgetPasswordActionReport,
    required this.resetPassword,
    required this.resetPasswordActionReport,
    required this.resendOTP,
    required this.getMyProfile,
  });

  static AuthViewModel fromStore(Store<AppState> store) {
    return AuthViewModel(
      user: store.state.authState.user,
      userId: store.state.authState.userId,
      socialMedia: store.state.authState.socialMedia.values.toList(),
      login: (phone, password) {
        store.dispatch(LoginAction(phone: phone, password: password));
      },
      logout: () {
        store.dispatch(LogOutAction());
      },
      register: (phone, password, userName, email) {
        store.dispatch(RegisterAction(
          phone: phone,
          userName: userName,
          password: password,
          email: email,
        ));
      },
      verify: (phone, code) {
        store.dispatch(VerifyPhoneAction(phone: phone, code: code));
      },
      sendOTP: (userId) {
        store.dispatch(SendOTPAction(userId: userId));
      },
      setUser: (user) {
        store.dispatch(SyncUserAction(user: user));
      },
      getSocialMedia: () {
        store.dispatch(GetSocialMediaAction());
      },
      editProfile: (user) {
        store.dispatch(EditProfileAction(user: user));
      },
      deleteAccount: () {
        store.dispatch(DeleteAccountAction());
      },
      forgetPassword: (phone) {
        store.dispatch(ForgetPasswordAction(phone));
      },
      checkOTP: (phone, code) {
        store.dispatch(ForgetPasswordCheckOTPAction(phone, code));
      },
      resetPassword: (password) {
        store.dispatch(ResetPasswordAction(password));
      },
      resendOTP: (phone) {
        store.dispatch(ResendOTPAction(phone));
      },
      getMyProfile: () {
        store.dispatch(GetUserProfileAction());
      },
      resetPasswordActionReport: store.state.authState.status['ResetPasswordAction'] ?? ActionReport(),
      checkOTPActionReport: store.state.authState.status['ForgetPasswordCheckOTPAction'] ?? ActionReport(),
      forgetPasswordActionReport: store.state.authState.status['ForgetPasswordAction'] ?? ActionReport(),
      deleteAccountActionReport: store.state.authState.status['DeleteAccountAction'] ?? ActionReport(),
      editProfileActionReport: store.state.authState.status['EditProfileAction'] ?? ActionReport(),
      logoutActionReport: store.state.authState.status['LogOutAction'] ?? ActionReport(),
      getSocialMediaActionReport: store.state.authState.status['GetSocialMediaAction'] ?? ActionReport(),
      loginActionReport: store.state.authState.status['LoginAction'] ?? ActionReport(),
      registerActionReport: store.state.authState.status['RegisterAction'] ?? ActionReport(),
      verifyActionReport: store.state.authState.status['VerifyPhoneAction'] ?? ActionReport(),
      resendOTPActionReport: store.state.authState.status['ResendOTPAction'] ?? ActionReport(),
    );
  }
}
