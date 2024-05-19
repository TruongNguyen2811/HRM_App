import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/model/response/list_leave_response.dart';
import 'package:hrm/presentation/list_leave/list_leave_state.dart';
import 'package:hrm/services/api/api_result.dart';
import 'package:hrm/services/api/network_exceptions.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class ListLeaveCubit extends Cubit<ListLeaveState> {
  ListLeaveCubit() : super(ListLeaveInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();

  bool get isLoggedIn => _pref.isLoggedIn;

  ProfileAuthResponse profileAuthResponse = ProfileAuthResponse();
  int prePosition = 0;
  getData() {
    profileAuthResponse = _pref.userProfile ?? ProfileAuthResponse();
  }

  List<LeaveInfo> listBooking = [];

  getListBookingRoom() async {
    emit(ListLeaveLoading());
    AttendanceRequest request = AttendanceRequest(
        params:
            AttendanceModel(args: ["", "", "", "", "", "", "", "", "", 10, 1]));
    ApiResult<ListLeaveResponse> apiResult =
        await repository.getLeaveListv2(body: request);
    apiResult.when(success: (data) {
      try {
        listBooking = data.result ?? [];

        emit(ListLeaveSuccess());
      } catch (e) {
        emit(ListLeaveFailure(messageError: 'Đã xảy ra lỗi không mong muốn'));
      }
    }, failure: (NetworkExceptions error) {
      emit(ListLeaveFailure(
          messageError: NetworkExceptions.getErrorMessage(error)));
    });
  }
}
