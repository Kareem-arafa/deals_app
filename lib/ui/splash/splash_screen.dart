import 'dart:async';
import 'dart:convert';

import 'package:dealz/data/models/user.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/ui/auth/auth_viewmodel.dart';
import 'package:dealz/ui/main_bottom_navigation/main_bottom_navigation.dart';
import 'package:dealz/ui/splash/get_started_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      distinct: true,
      converter: (store) => AuthViewModel.fromStore(store),
      builder: (_, viewModel) => _SplashScreenContent(
        viewModel: viewModel,
      ),
    );
  }
}

class _SplashScreenContent extends StatefulWidget {
  final AuthViewModel viewModel;

  const _SplashScreenContent({super.key, required this.viewModel});

  @override
  State<_SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<_SplashScreenContent> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    SharedPreferences.getInstance().then((prefs) {
      final isLogin = prefs.getBool('isLogined') ?? false;
      if (isLogin) {
        final JsonDecoder _decoder = new JsonDecoder();
        try {
          UserModel user = UserModel.fromJson(_decoder.convert(prefs.getString("user")!));
          this.widget.viewModel.setUser(user);
          Navigator.of(context).pushNamedAndRemoveUntil("/main", (route) => false);
        } on Exception catch (e) {
          print(e);
          prefs.clear();
        }
      } else {
        prefs.clear();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => GetStartedscreen()), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            child: Image.asset(Assets.images.intro.path),
          ),
        ),
      ),
    );
  }
}
