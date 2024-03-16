import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hrm/model/request/login_request.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/services/api/app_client.dart';
import 'package:hrm/utils/logger.dart';
import 'package:hrm/utils/utils.dart';
import 'package:logger/logger.dart';
import '../api/api_result.dart';
import 'app_repository.dart';

class AppRepository extends BaseRepository {
  Future<ApiResult<AuthResponse>> login({required LoginRequest body}) async {
    try {
      final response = await appClient.login(body);

      if (!Utils.isEmpty(response.error)) {
        print('check error 123');
        return handleErrorApi('Đã xảy ra lối không mong muôn');
      }
      print('12311111111111 ${response}');
      logger.e(response.error);

      return ApiResult.success(data: response.result ?? AuthResponse());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return handleErrorApi(e);
    }
  }
}
