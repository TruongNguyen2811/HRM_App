import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/response/attendance_response.dart';
import 'package:hrm/presentation/time_keeping/time_keeping_state.dart';
import 'package:hrm/services/api/api_result.dart';
import 'package:hrm/services/api/network_exceptions.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/utils/date_extension.dart';
import '../../injection_container.dart';
import '../../services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class TimeKeepingCubit extends Cubit<TimeKeepingState> {
  TimeKeepingCubit() : super(TimeKeepingInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();
  TextEditingController datePicker = TextEditingController();
  List<AttendanceResponse> attendance = [];

  getAttendance() async {
    emit(TimeKeepingLoading());
    AttendanceRequest request = AttendanceRequest(
        params: AttendanceModel(args: [
      '${datePicker.text.split('-')[0]}',
      '${datePicker.text.split('-')[1]}',
      'APG230316002'
    ]));
    ApiResult<List<AttendanceResponse>> apiResult =
        await repository.getAttendanceReport(body: request);
    apiResult.when(
      success: (data) {
        try {
          attendance = data;

          emit(TimeKeepingGetDataSuccess());
        } catch (e) {
          emit(TimeKeepingFailure(
              messageError: 'Đã xảy ra lỗi không mong muốn'));
        }
      },
      failure: (error) {
        emit(TimeKeepingFailure(
            messageError: NetworkExceptions.getErrorMessage(error)));
      },
    );
  }
}
