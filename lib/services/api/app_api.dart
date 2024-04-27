// import 'package:app_camera/model/confirm_image.dart';
import 'package:dio/dio.dart';
import 'package:hrm/model/base/base_response.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/request/login_request.dart';
import 'package:hrm/model/response/attendance_response.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/model/response/employee_info_response.dart';
import 'package:hrm/model/response/kpi_response.dart';
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
}
