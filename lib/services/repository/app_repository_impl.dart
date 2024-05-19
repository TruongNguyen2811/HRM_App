import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/request/login_request.dart';
import 'package:hrm/model/response/attendance_response.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/model/response/employee_info_response.dart';
import 'package:hrm/model/response/kpi_response.dart';
import 'package:hrm/model/response/list_booking_room_response.dart';
import 'package:hrm/model/response/list_equipment_response.dart';
import 'package:hrm/model/response/list_leave_response.dart';
import 'package:hrm/model/response/list_quotes.dart';
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

  Future<ApiResult<List<Quotes>>> getListQuotes(
      {required AttendanceRequest body}) async {
    try {
      final response = await appClient.getListQuotes(body);

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

  Future<ApiResult<SuccessMessage>> createLeaveRequest(
      {required String employee_code,
      required String time_keeping_code,
      required String from_date,
      required String to_date,
      required String reasons,
      required String holiday_status_id,
      required String hours,
      required String company}) async {
    try {
      print(
          'check send ${employee_code} , ${time_keeping_code}, ${employee_code}, ${from_date}, ${to_date}, ${reasons}, ${holiday_status_id}, ${hours}, ${company}');
      SuccessMessage response =
          await appClient.createLeaveRequest(wrapMapFormData({
        "employee_code": employee_code,
        "time_keeping_code": time_keeping_code,
        "from_date": from_date,
        "to_date": to_date,
        // "for_reasons": for_reasons,
        "reasons": reasons,
        "holiday_status_id": holiday_status_id,
        "hours": hours,
        "company": company,
      }));
      return ApiResult.success(data: response);
    } catch (e) {
      return handleErrorApi(e);
    }
  }

  Future<ApiResult<SuccessMessage>> changePassWord(
      {required AttendanceRequest body}) async {
    try {
      final response = await appClient.changePassWord(body);
      return ApiResult.success(data: response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return handleErrorApi(e);
    }
  }

  Future<ApiResult<ListBookingRoomResponse>> getListBookingRoom(
      {required AttendanceRequest body}) async {
    try {
      final response = await appClient.getListBookingRoom(body);

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

  Future<ApiResult<ListLeaveResponse>> getLeaveListv2(
      {required AttendanceRequest body}) async {
    try {
      final response = await appClient.getLeaveListv2(body);

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

  Future<ApiResult<ListEquipmentResponse>> getEquipmentList(
      {required AttendanceRequest body}) async {
    try {
      final response = await appClient.getEquipmentList(body);

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
}
