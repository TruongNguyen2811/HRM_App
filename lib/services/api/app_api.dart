// import 'package:app_camera/model/confirm_image.dart';
import 'package:dio/dio.dart';
import 'package:hrm/model/base/base_response.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/request/login_request.dart';
import 'package:hrm/model/response/attendance_response.dart';
import 'package:hrm/model/response/auth_response.dart';
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
}
