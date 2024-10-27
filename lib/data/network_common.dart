import 'dart:convert';

import 'package:dealz/common/toast_utils.dart';
import 'package:dealz/data/models/error_model.dart';
import 'package:dealz/main.dart';
import 'package:dealz/ui/trend/trend_ad_store_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkCommon {
  static final NetworkCommon _singleton = NetworkCommon._internal();
  static const String baseUrl = "https://phplaravel-1277060-4616404.cloudwaysapps.com/api/";

  factory NetworkCommon() {
    return _singleton;
  }

  NetworkCommon._internal();

  final JsonDecoder _decoder = const JsonDecoder();

  dynamic decodeResp(d) {
    if (d is Response) {
      final dynamic jsonBody = d.data;
      final statusCode = d.statusCode;

      if (statusCode! < 200 || statusCode >= 300 || jsonBody == null) {
        throw Exception("statusCode: $statusCode");
      }

      if (jsonBody is String && jsonBody.isNotEmpty) {
        return _decoder.convert(jsonBody);
      } else {
        return jsonBody;
      }
    } else {
      throw d;
    }
  }

  Dio get dio {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = Duration(minutes: 5);
    dio.options.receiveTimeout = Duration(minutes: 3);
    if (kDebugMode) dio.interceptors.add(alice.getDioInterceptor());
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      request: true,
    ));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString('token');
          options.headers["Accept"] = "application/json";
          options.headers["Accept-Language"] = prefs.getString("lang") ?? "en";
          if (token != null) {
            if (options.path != "customer/login" || options.path != "customer/register") {
              options.headers["Authorization"] = "Bearer " + token;
            }
          }

          print("Pre request:${options.method},${options.baseUrl}${options.path}");
          print("Pre request:${options.headers.toString()}");
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          final int? statusCode = response.statusCode;
          if (statusCode! < 300) {
            if (response.requestOptions.path == "customer/login" ||
                response.requestOptions.path == "customer/register") {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              final resultContainer = response.data;
              final bool isVerified = resultContainer['data']['verified'];
              prefs.setString("token", resultContainer['data']['token']);
              if (isVerified) {
                prefs.setBool("isLogined", true);
                JsonEncoder _encoder = const JsonEncoder();
                prefs.setString("user", _encoder.convert(resultContainer['data'] as Map));
              }
            } else if (response.requestOptions.path == "customer/verify") {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              final resultContainer = response.data;
              final bool isVerified = resultContainer['data']['verified'];
              if (isVerified) {
                prefs.setBool("isLogined", true);
                JsonEncoder _encoder = const JsonEncoder();
                prefs.setString("user", _encoder.convert(resultContainer['data'] as Map));
              }
            } else if (response.requestOptions.path == "user/profile/edit") {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              JsonEncoder _encoder = const JsonEncoder();

              final resultContainer = response.data;

              prefs.setString("user", _encoder.convert(resultContainer['user'] as Map));
            }
            return handler.next(response); // continue
          }
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401 && !e.requestOptions.path.contains("login")) {
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.clear();
            if (!e.requestOptions.path.contains("logout")) {
              showCreateUserBottomSheet(navigatorKey.currentContext!);
            }
          }
          final error = e.response?.data['errors'] ?? e.response?.data;
          if (error != null) {
            final errorModel = ErrorModel.fromJson(error);
            showToast(errorModel.errorMessage);
          }
          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}
