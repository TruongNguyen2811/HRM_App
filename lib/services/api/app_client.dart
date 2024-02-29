import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hrm/services/api/curl_logger_dio_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_api.dart';

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
    dio = Dio(BaseOptions(
        baseUrl: "",
        receiveTimeout: 60 * 1000 * 2,
        connectTimeout: 60 * 1000 * 2,
        contentType: "application/json"));
    dio
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

    if (kDebugMode) {
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
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // options.headers["Authorization"] = "Bearer ${appEnv.option1?.bearerToken}";
      // dio.options.headers["Authorization"] = "Bearer ${appEnv.option1?.bearerToken}";

      return handler.next(options);
    }, onResponse: (response, handler) async {
      // logger.d("<-- ${respons
      return handler.next(response);
    }, onError: (DioError error, ErrorInterceptorHandler handler) async {
      // logger.d("DioError request: ${error.requestOptions.toString()}");
      // logger.d("DioError message: ${error.message}");
      // String? refreshToken = pref.getString(AppPreferences.KEY_REFRESH_TOKEN);
      // try {
      //   if (error.response?.statusCode == 401) {
      //     logger.i("Need refresh token");
      //     Dio tokenDio = Dio();
      //     tokenDio.options = dio.options;
      //     dio.lock();
      //     dio.interceptors.requestLock.lock();
      //     dio.interceptors.responseLock.lock();
      //     RequestOptions options = error.response?.requestOptions ?? error.requestOptions;
      //     Response refreshResponse = await tokenDio.get("v2/auth/token/refresh", queryParameters: {"refreshToken": refreshToken});
      //     if (refreshResponse.statusCode == 200) {
      //       String newToken = refreshResponse.data["accessToken"];
      //       _pref.setData(AppPreferences.KEY_AUTH_TOKEN, newToken);
      //       if (options.headers.containsKey("Authorization") == true) {
      //         options.headers.update("Authorization", (value) => newToken);
      //       } else {
      //         options.headers.addAll({"Authorization": newToken});
      //       }
      //       if (dio.options.headers.containsKey("Authorization")) {
      //         dio.options.headers.update("Authorization", (value) => newToken);
      //       } else {
      //         dio.options.headers.addAll({"Authorization": newToken});
      //       }
      //       dio.unlock();
      //       dio.interceptors.requestLock.unlock();
      //       dio.interceptors.responseLock.unlock();
      //       Response newResponse = await dio.fetch(options);
      //       return handler.resolve(newResponse);
      //     } else {
      //       dio.interceptors.requestLock.unlock();
      //       dio.interceptors.responseLock.unlock();
      //       return handler.next(error);
      //     }
      //   }
      // } catch (e) {
      //   logger.e(e);
      // }
      return handler.next(error); //continue
    }));
    appClient = AppApi(dio);
  }
}

AppApi appClient = AppClient().appClient;
Link link = AppClient().link;
Dio dio = AppClient().dio;
