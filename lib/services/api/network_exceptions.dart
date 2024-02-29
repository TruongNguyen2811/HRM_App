import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrm/utils/logger.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String? reason) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest(String? reason) = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(
      String errorCode, String message, dynamic data) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(dynamic data, int? statusCode) {
    String? message;
    String? errorCode;
    print('status code ${statusCode}');
    print('check logger fail data ${data}');
    // logger.e(data);

    if (data.toString().contains("detail")) {
      message = data["detail"].toString();
    }
    if (data.toString().contains("errorCode")) {
      print('check logger fail data2 ${data}');
      errorCode = data["errorCode"].toString();
    }

    if (data is String) {
      print('check logger fail data3 ${data}');
      message = data;
    }

    if (statusCode == 401) {
      return NetworkExceptions.unauthorizedRequest(message);
    }

    if (message!.isNotEmpty) {
      print('check logger fail data4 ${data}');
      return NetworkExceptions.defaultError(
          errorCode ?? statusCode.toString(), message, data["detail"]);
    }

    switch (statusCode) {
      case 400:
      // print('13123 ${data["detail"]}');
      // return NetworkExceptions.defaultError(
      //     errorCode ?? statusCode.toString(), message, data["detail"]);
      case 403:
        return NetworkExceptions.badRequest(message);
      case 401:
        // case 403:
        return NetworkExceptions.unauthorizedRequest(message);
      case 404:
        return const NetworkExceptions.notFound("Not found");
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      case 501:
        return NetworkExceptions.defaultError(
            errorCode ?? statusCode.toString(), message, data["detail"]);
      default:
        return NetworkExceptions.defaultError(
            errorCode ?? statusCode.toString(), message, data["detail"]);
    }
  }

  static NetworkExceptions getDioException(error) {
    NetworkExceptions networkExceptions;
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.connectTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.other:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.response:
              networkExceptions = NetworkExceptions.handleResponse(
                  error.response?.data is String
                      ? json.decode(error.response?.data ?? "")
                      : error.response?.data,
                  error.response?.statusCode);
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        // Helper.printError(e.toString());
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(notImplemented: () {
      errorMessage = "The request not fulfilled";
    }, requestCancelled: () {
      errorMessage = "The request has been cancelled";
    }, internalServerError: () {
      errorMessage = 'Server error';
    }, notFound: (String reason) {
      print('check error reason');
      logger.d(reason);
      errorMessage = "Sever not found";
    }, serviceUnavailable: () {
      errorMessage = 'Service is not available';
    }, methodNotAllowed: () {
      errorMessage = 'Method not allowed';
    }, badRequest: (String? reason) {
      errorMessage = reason ?? 'Bad request';
    }, unauthorizedRequest: (reason) {
      errorMessage = reason ?? 'You do not have access';
    }, unexpectedError: () {
      print('unexpectedError');
      errorMessage = 'An unexpected error occurred';
    }, requestTimeout: () {
      errorMessage = 'Connection request timed out';
    }, noInternetConnection: () {
      errorMessage = 'Connection interrupted!';
    }, conflict: () {
      errorMessage = 'Error due to conflict';
    }, sendTimeout: () {
      errorMessage = 'Timeout sent connection to server';
    }, unableToProcess: () {
      errorMessage = 'Unable to process data';
    }, defaultError: (String errorCode, String message, dynamic data) {
      errorMessage = message;
    }, formatException: () {
      print('formatExeption');
      errorMessage = 'An unexpected error occurred';
    }, notAcceptable: () {
      errorMessage = 'Request is not accepted';
    });
    return errorMessage;
  }
}
