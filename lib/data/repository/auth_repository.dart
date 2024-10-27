import 'package:dealz/data/models/social_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/data/network_common.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  const AuthRepository();

  Future<UserModel> login(String phone, String password) {
    return new NetworkCommon().dio.post("customer/login", data: {
      "phone": phone,
      "password": password,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return UserModel.fromJson(results['data']);
      },
    );
  }

  Future<UserModel> createUserAccount(String phone, String userName, String password, String email) {
    return new NetworkCommon().dio.post("customer/register", data: {
      "phone": phone,
      "password": password,
      "name": userName,
      "password_confirmation": password,
      "email": email,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return UserModel.fromJson(results['data']);
      },
    );
  }

  Future<UserModel> verifyPhone(String code) {
    return new NetworkCommon().dio.post("customer/verify", data: {
      "otp": code,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return UserModel.fromJson(results['data']);
      },
    );
  }

  Future<bool> sendOTP(int userId) {
    return new NetworkCommon().dio.post("sendotp/$userId").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> resendOTP(String phone) {
    return new NetworkCommon().dio.post("customer/verify/resend", data: {
      "phone": phone,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<List<SocialMediaModel>> getSocialMedia() {
    return new NetworkCommon().dio.get("social/accounts").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['socialLinks'] as List).map((e) => SocialMediaModel.fromJson(e)).toList();
      },
    );
  }

  Future<bool> logout() {
    return new NetworkCommon().dio.get("customer/logout").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<UserModel> updateProfile(UserModel user) {
    return new NetworkCommon().dio.post("customer/profile", data: user.toJson()).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return UserModel.fromJson(results['data']);
      },
    );
  }

  Future<bool> deleteUser() {
    return new NetworkCommon().dio.delete("customer/profile").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> forgetPassword(String phone) {
    return new NetworkCommon().dio.post("customer/forget-password", data: {
      "phone": phone,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<String> forgetPasswordCheckOTP(String phone, String otp) {
    return new NetworkCommon().dio.post("customer/forget-password/check-otp", data: {
      "phone": phone,
      "otp": otp,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return results['data']['token'];
      },
    );
  }

  Future<bool> resetPassword(String password, String token) {
    return new NetworkCommon()
        .dio
        .put(
          "customer/reset-password",
          data: {
            "password": password,
            "password_confirmation": password,
          },
          options: Options(
            headers: {
              "Authorization": "Bearer " + token,
            },
          ),
        )
        .then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<UserModel> getMyProfile() {
    return new NetworkCommon().dio.get("customer/profile").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return UserModel.fromJson(results['data']);
      },
    );
  }
}
