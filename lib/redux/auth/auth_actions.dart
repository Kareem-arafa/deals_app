import 'package:dealz/data/models/social_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/redux/action_report.dart';

class AuthStatusAction {
  final String actionName = "AuthStatusAction";
  final ActionReport report;

  AuthStatusAction({required this.report});
}

class LoginAction {
  final String actionName = "LoginAction";
  final String phone;
  final String password;

  LoginAction({
    required this.phone,
    required this.password,
  });
}

class RegisterAction {
  final String actionName = "RegisterAction";
  final String phone;
  final String userName;
  final String password;
  final String email;

  RegisterAction({
    required this.phone,
    required this.userName,
    required this.password,
    required this.email,
  });
}

class VerifyPhoneAction {
  final String actionName = "VerifyPhoneAction";
  final String phone;
  final String code;

  VerifyPhoneAction({
    required this.phone,
    required this.code,
  });
}

class SendOTPAction {
  final String actionName = "SendOTPAction";
  final int userId;

  SendOTPAction({
    required this.userId,
  });
}

class SyncUserAction {
  final String actionName = "SyncUserAction";
  final UserModel user;

  SyncUserAction({
    required this.user,
  });
}

class SyncUserIdAction {
  final String actionName = "SyncUserIdAction";
  final int userId;

  SyncUserIdAction({
    required this.userId,
  });
}

class LogOutAction {
  final String actionName = "LogOutAction";

  LogOutAction();
}

class GetSocialMediaAction {
  final String actionName = "GetSocialMediaAction";

  GetSocialMediaAction();
}

class SyncSocialMediaAction {
  final String actionName = "SyncSocialMediaAction";
  final List<SocialMediaModel> socialMedia;

  SyncSocialMediaAction({
    required this.socialMedia,
  });
}

class EditProfileAction {
  final String actionName = "EditProfileAction";
  final UserModel user;

  EditProfileAction({
    required this.user,
  });
}

class DeleteAccountAction {
  final String actionName = "DeleteAccountAction";

  DeleteAccountAction();
}

class ForgetPasswordAction {
  final String actionName = "ForgetPasswordAction";
  final String phone;

  ForgetPasswordAction(this.phone);
}

class ForgetPasswordCheckOTPAction {
  final String actionName = "ForgetPasswordCheckOTPAction";
  final String phone;
  final String code;

  ForgetPasswordCheckOTPAction(this.phone, this.code);
}

class SyncTokenAction {
  final String actionName = "SyncTokenAction";
  final String token;

  SyncTokenAction(this.token);
}

class ResetPasswordAction {
  final String actionName = "ResetPasswordAction";
  final String password;

  ResetPasswordAction(this.password);
}

class ResendOTPAction {
  final String actionName = "ResendOTPAction";
  final String phone;

  ResendOTPAction(this.phone);
}

class GetUserProfileAction {
  final String actionName = "GetUserProfileAction";

  GetUserProfileAction();
}
