import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/response/employee_info_response.dart';
import 'package:hrm/model/response/room_info_response.dart';
import 'package:hrm/model/response/success_message_response.dart';
import 'package:hrm/presentation/booking_room/booking_room_state.dart';
import 'package:hrm/presentation/create_order/create_order_state.dart';
import 'package:hrm/services/api/api_result.dart';
import 'package:hrm/services/api/network_exceptions.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/utils/date_extension.dart';
import 'package:hrm/utils/string_extension.dart';
import 'package:hrm/utils/utils.dart';
import '../../injection_container.dart';
import '../../services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class BookingRoomCubit extends Cubit<BookingRoomState> {
  BookingRoomCubit() : super(BookingRoomState());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();
  TextEditingController fromDate = TextEditingController();
  TextEditingController reason = TextEditingController();
  DateTime bookingTimeFrom = DateTime.now();

  DateTime bookingTimeTo = DateTime.now();

  setTime(DateTime timer) {
    emit(BookingRoomLoading());
    bookingTimeFrom = timer;
    emit(BookingRoomChooseTime());
  }

  Future<void> Submit() async {
    emit(BookingRoomLoading());
    // print(
    //     'check date ${DateFormat('dd-MM-yyyy hh:mm:ss a').parse(fromDate.text).toStringFormat(AppDateFormat.yearMonthDay)}');
    DateTime bookingFrom = DateTime(
      fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).year,
      fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).month,
      fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).day,
      bookingTimeFrom.hour,
      bookingTimeFrom.minute,
      bookingTimeFrom.second,
    );
    DateTime bookingTo = DateTime(
      fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).year,
      fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).month,
      fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).day,
      bookingTimeTo.hour,
      bookingTimeTo.minute,
      bookingTimeTo.second,
    );
    final ApiResult<SuccessMessage> response =
        await repository.createBookingRoom(
      room: infoRoomChoose?.id.toString() ?? '',
      employee: employeeChoose?.id.toString() ?? '',
      req_date: fromDate.text
          .toDateFormat(AppDateFormat.dayMonthYear)
          .toStringFormat(AppDateFormat.yearMonthDay),
      date_from: bookingFrom
          .toStringFormat(AppDateFormat.yearMonthDayHourMinuteSecondSSS),
      date_to: bookingTo
          .toStringFormat(AppDateFormat.yearMonthDayHourMinuteSecondSSS),
      purpose: reason.text,
    );
    response.when(success: (data) {
      print(
          'check data ${infoRoomChoose?.id.toString() ?? ''}, ${employeeChoose?.id.toString() ?? ''}, ${fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).toStringFormat(AppDateFormat.yearMonthDay)},${bookingTimeFrom.toStringFormat(AppDateFormat.yearMonthDayHourMinuteSecondSSS)}, ${bookingTimeTo.toStringFormat(AppDateFormat.yearMonthDayHourMinuteSecondSSS)}');
      // emit(FormForPageInitial());
      // emit(FormForPageFailure('123'));
      try {
        SuccessMessage listRoom = data;

        emit(BookingRoomSuccess());
      } catch (e) {
        emit(BookingRoomFailure(messageError: 'Đã xảy ra lỗi không mong muốn'));
      }

      // emit(state);
    }, failure: (error) {
      emit(BookingRoomFailure(
          messageError: NetworkExceptions.getErrorMessage(error)));
    });
  }

  setTimeTo(DateTime timer) {
    emit(BookingRoomLoading());
    bookingTimeTo = timer;
    emit(BookingRoomChooseTime());
  }

  List<InfoRoom> listRoom = [];
  InfoRoom? infoRoomChoose;
  chooseRoom(InfoRoom? infoRoom) {
    emit(BookingRoomLoading());
    infoRoomChoose = infoRoom;
    emit(BookingRoomChooseRoomSuccess());
  }

  getListRoom() async {
    emit(BookingRoomLoading());
    AttendanceRequest request =
        AttendanceRequest(params: AttendanceModel(args: ["", "", "", ""]));
    ApiResult<ListRoomResponse> apiResult =
        await repository.getListRoom(body: request);
    apiResult.when(
      success: (data) {
        try {
          listRoom = data.result ?? [];

          emit(BookingRoomGetRoomSuccess());
        } catch (e) {
          emit(BookingRoomFailure(
              messageError: 'Đã xảy ra lỗi không mong muốn'));
        }
      },
      failure: (error) {
        emit(BookingRoomFailure(
            messageError: NetworkExceptions.getErrorMessage(error)));
      },
    );
  }

  List<EmployeeInfo> listEmployee = [];
  EmployeeInfo? employeeChoose;
  chooseEmployee(EmployeeInfo? employeeInfo) {
    emit(BookingRoomLoading());
    employeeChoose = employeeInfo;
    emit(BookingRoomChooseEmployeeSuccess());
  }

  getListEmployee() async {
    emit(BookingRoomLoading());
    AttendanceRequest request =
        AttendanceRequest(params: AttendanceModel(args: ["", "", "", ""]));
    ApiResult<ListEmployeeResponse> apiResult =
        await repository.getListEmployee(body: request);
    apiResult.when(
      success: (data) {
        try {
          listEmployee = data.result ?? [];

          emit(BookingRoomGetRoomSuccess());
        } catch (e) {
          emit(BookingRoomFailure(
              messageError: 'Đã xảy ra lỗi không mong muốn'));
        }
      },
      failure: (error) {
        emit(BookingRoomFailure(
            messageError: NetworkExceptions.getErrorMessage(error)));
      },
    );
  }
}
