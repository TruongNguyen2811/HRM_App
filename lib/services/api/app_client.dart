import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/utils/const.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../injection_container.dart';
import '../../start.dart';
import '../../utils/logger.dart';
import '../../utils/utils.dart';
import 'app_api.dart';
import 'curl_logger_dio_interceptor.dart';

const _defaultConnectTimeout = 5 * Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = 5 * Duration.millisecondsPerMinute;

class AppClient {
  late AppApi appClient;
  late Link link;
  late Dio dio;

  AppClient._privateConstructor() {
    _setupClient();
  }

  static final AppClient _instance = AppClient._privateConstructor();

  factory AppClient() {
    return _instance;
  }

  void _setupClient() {
    final AppPreferences pref = getIt<AppPreferences>();

    dio = Dio(BaseOptions(
        baseUrl:
            'https://5f3c-2405-4803-a0f2-4580-78cd-8ee7-4c6b-3ce9.ngrok-free.app/',
        receiveTimeout: 60 * 1000 * 2,
        connectTimeout: 60 * 1000 * 2,
        contentType: "application/json"));
    dio
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    if (kDebugMode) {
      // dio.interceptors.add(alice.getDioInterceptor());
      dio.interceptors.add(CurlLoggerDioInterceptor());

      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 1000));
    }
    // if (F.appFlavor != Flavor.PROD && Platform.isAndroid) {
    //   dio.interceptors.add(alice.getDioInterceptor());
    // }

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String? accessToken = pref.authToken;
      bool isLoggedIn = pref.isLoggedIn;
      if (options.headers['Authorization'] != Consts.BASIC_AUTH) {
        if (isLoggedIn || !Utils.isEmpty(accessToken)) {
          options.headers["access-token"] = "$accessToken";
          logger.i(accessToken);
          dio.options.headers["access-token"] = "$accessToken";
        }
      }
      return handler.next(options);
    }, onResponse: (response, handler) async {
      return handler.next(response);
    }, onError: (DioError error, ErrorInterceptorHandler handler) async {
      return handler.next(error); //continue
    }));
    appClient = AppApi(dio);
  }
}

AppApi appClient = AppClient().appClient;
Link link = AppClient().link;
Dio dio = AppClient().dio;
