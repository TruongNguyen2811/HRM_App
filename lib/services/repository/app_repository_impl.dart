import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/request/login_request.dart';
import 'package:hrm/model/response/attendance_response.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/model/response/employee_info_response.dart';
import 'package:hrm/model/response/kpi_response.dart';
import 'package:hrm/model/response/room_info_response.dart';
import 'package:hrm/model/response/success_message_response.dart';
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

  Future<ApiResult<List<AttendanceResponse>>> getAttendanceReport(
      {required AttendanceRequest body}) async {
    try {
      final response = await appClient.getAttendanceReport(body);

      if (!Utils.isEmpty(response.error)) {
        print('check error 123');
        return handleErrorApi('Đã xảy ra lối không mong muôn');
      }
      print('12311111111111 ${response}');
      logger.e(response.error);

      return ApiResult.success(data: response.result ?? []);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return handleErrorApi(e);
    }
  }

  Future<ApiResult<List<KPIResponse>?>> getKPIReport(
      {String? query, String? filter}) async {
    try {
      final response = await appClient.getKPI(query, filter);

      if (!Utils.isEmpty(response.error)) {
        print('check error 123');
        return handleErrorApi('Đã xảy ra lối không mong muôn');
      }
      print('12311111111111 ${response}');
      logger.e(response.error);

      return ApiResult.success(data: response.result);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return handleErrorApi(e);
    }
  }

  Future<ApiResult<ListEmployeeResponse>> getListEmployee(
      {required AttendanceRequest body}) async {
    try {
      final response = await appClient.getListEmployee(body);

      if (!Utils.isEmpty(response.error)) {
        print('check error 123');
        return handleErrorApi('Đã xảy ra lối không mong muôn');
      }
      print('12311111111111 ${response}');
      logger.e(response.error);

      return ApiResult.success(data: response.result);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return handleErrorApi(e);
    }
  }

  Future<ApiResult<ListRoomResponse>> getListRoom(
      {required AttendanceRequest body}) async {
    try {
      final response = await appClient.getListRoom(body);

      if (!Utils.isEmpty(response.error)) {
        print('check error 123');
        return handleErrorApi('Đã xảy ra lối không mong muôn');
      }
      print('12311111111111 ${response}');
      logger.e(response.error);

      return ApiResult.success(data: response.result);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return handleErrorApi(e);
    }
  }

  Future<ApiResult<SuccessMessage>> createBookingRoom(
      {required String room,
      required String employee,
      required String req_date,
      required String date_from,
      required String date_to,
      required String purpose}) async {
    try {
      SuccessMessage response =
          await appClient.createBookingRoom(wrapMapFormData({
        "room": room,
        "employee": employee,
        "req_date": req_date,
        "date_from": date_from,
        "date_to": date_to,
        "purpose": purpose,
      }));
      return ApiResult.success(data: response);
    } catch (e) {
      return handleErrorApi(e);
    }
  }
}
