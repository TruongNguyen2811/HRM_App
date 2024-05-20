// import 'package:app_camera/model/confirm_image.dart';
import 'package:dio/dio.dart';
import 'package:hrm/model/base/base_response.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/request/login_request.dart';
import 'package:hrm/model/response/attendance_response.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/model/response/contract_response.dart';
import 'package:hrm/model/response/department_list_response.dart';
import 'package:hrm/model/response/employee_info_response.dart';
import 'package:hrm/model/response/kpi_response.dart';
import 'package:hrm/model/response/list_booking_room_response.dart';
import 'package:hrm/model/response/list_equipment_response.dart';
import 'package:hrm/model/response/list_leave_response.dart';
import 'package:hrm/model/response/list_quotes.dart';
import 'package:hrm/model/response/room_info_response.dart';
import 'package:hrm/model/response/success_message_response.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @POST('auth')
  Future<BaseResponse<AuthResponse>> login(
    @Body() LoginRequest body,
  );

  @POST('object/hr.apec.attendance.report/get_attendance_reportv3')
  Future<BaseResponse<List<AttendanceResponse>?>> getAttendanceReport(
    @Body() AttendanceRequest body,
  );

  @GET('api/kpi.weekly.report.summary')
  Future<BaseResponse<List<KPIResponse>?>> getKPI(
    @Query('query') String? query,
    @Query('filter') String? filter,
  );

  @POST('//object/meeting.room/get_meeting_rooms')
  Future<BaseResponse<ListRoomResponse>> getListRoom(
    @Body() AttendanceRequest body,
  );

  @POST('//object/hr.employee/get_employee_list')
  Future<BaseResponse<ListEmployeeResponse>> getListEmployee(
    @Body() AttendanceRequest body,
  );

  @POST("/create_booking_room")
  Future<SuccessMessage> createBookingRoom(
    @Body() dynamic body,
  );

  @POST('//object/hr.leave/get_list_leave')
  Future<BaseResponse<List<Quotes>>> getListQuotes(
    @Body() AttendanceRequest body,
  );

  @POST("///create_leave_request")
  Future<BaseResponse<SuccessMessage>> createLeaveRequest(
    @Body() dynamic body,
  );

  @POST("////object/hr.employee/change_user_password_general_manager")
  // params: {args: [5859, "apec123"]}
  Future<BaseResponse<SuccessMessage>> changePassWord(
    @Body() AttendanceRequest body,
  );

  @POST("//object/employee.fleets/get_booking_rooms")
  // {params: {args: ["", "", "2024-05-18T02:31:30.900Z", "", "", "", "", 1, 10]}}
  Future<BaseResponse<ListBookingRoomResponse>> getListBookingRoom(
    @Body() AttendanceRequest body,
  );

  @POST("//object/hr.leave/get_leave_list_v2")
  Future<BaseResponse<ListLeaveResponse>> getLeaveListv2(
    // {params: {args: ["", "", "", "", "", "", "", "", "", 10, 1]}}
    @Body() AttendanceRequest body,
  );

  @POST("//object/equipment.request/get_equipment_request")
  Future<BaseResponse<ListEquipmentResponse>> getEquipmentList(
    // {params: {args: ["", "", "", "", "", "", "", "", "", 10, 1]}}
    @Body() AttendanceRequest body,
  );

  @POST("//object/hr.contract/get_contracts")
  Future<BaseResponse<ListContractResponse>> getContractInfo(
    // {params: {args: ["", "", "", "", "", "", "", "", "", 10, 1]}}
    @Body() AttendanceRequest body,
  );

  @POST("//object/hr.department/get_department_list")
  Future<BaseResponse<DepartmentList>> getDepartmentList(
    // {params: {args: ["", "", "", "", "", "", "", "", "", 10, 1]}}
    @Body() AttendanceRequest body,
  );
}
