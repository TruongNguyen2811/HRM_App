import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/model/response/list_booking_room_response.dart';
import 'package:hrm/presentation/list_booking/list_booking_state.dart';
import 'package:hrm/services/api/api_result.dart';
import 'package:hrm/services/api/network_exceptions.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class ListBookingCubit extends Cubit<ListBookingState> {
  ListBookingCubit() : super(ListBookingInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();

  bool get isLoggedIn => _pref.isLoggedIn;

  ProfileAuthResponse profileAuthResponse = ProfileAuthResponse();
  int prePosition = 0;
  getData() {
    profileAuthResponse = _pref.userProfile ?? ProfileAuthResponse();
  }

  List<BookingRoomInfo> listBooking = [];

  getListBookingRoom() async {
    emit(ListBookingLoading());
    AttendanceRequest request = AttendanceRequest(
        params: AttendanceModel(args: ["", "", "", "", "", "", "", 1, 10]));
    ApiResult<ListBookingRoomResponse> apiResult =
        await repository.getListBookingRoom(body: request);
    apiResult.when(success: (data) {
      try {
        listBooking = data.result ?? [];
        print('check length ${listBooking.length}');
        emit(ListBookingSuccess());
      } catch (e) {
        emit(ListBookingFailure(messageError: 'Đã xảy ra lỗi không mong muốn'));
      }
    }, failure: (NetworkExceptions error) {
      emit(ListBookingFailure(
          messageError: NetworkExceptions.getErrorMessage(error)));
    });
  }
}
