import 'package:dealz/data/models/social_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/redux/action_report.dart';

class AuthState {
  final Map<String, ActionReport> status;
  final UserModel? user;
  final int? userId;
  final Map<String, SocialMediaModel> socialMedia;
  final String? token;

  AuthState({
    required this.status,
    this.user,
    this.userId,
    required this.socialMedia,
    this.token,
  });

  factory AuthState.initial() {
    return AuthState(
      status: Map(),
      user: null,
      userId: null,
      socialMedia: Map(),
      token: null,
    );
  }

  AuthState copyWith({
    Map<String, ActionReport>? status,
    UserModel? user,
    int? userId,
    Map<String, SocialMediaModel>? socialMedia,
    String? token,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      socialMedia: socialMedia ?? this.socialMedia,
      token: token ?? this.token,
    );
  }
}
