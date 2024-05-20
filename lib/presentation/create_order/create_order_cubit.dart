import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/model/response/employee_info_response.dart';
import 'package:hrm/model/response/list_quotes.dart';
import 'package:hrm/model/response/room_info_response.dart';
import 'package:hrm/model/response/success_message_response.dart';
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

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CreateOrderInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();
  Quotes selectedQuote = Quotes();
  TextEditingController typeOrder = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController totalHours = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController minutes = TextEditingController();
  ProfileAuthResponse? user;

  getProfile() {
    user = _pref.userProfile;
  }
  // void Submit() {
  //   emit(CreateOrderSuccess());
  // }

  List<Quotes> listQuotes = [];

  getListQuotes() async {
    emit(CreateOrderLoading());
    AttendanceRequest request =
        AttendanceRequest(params: AttendanceModel(args: ["327637"]));
    ApiResult<List<Quotes>> apiResult =
        await repository.getListQuotes(body: request);
    apiResult.when(
      success: (data) {
        try {
          listQuotes = data ?? [];
          emit(GetListQuotesSuccess());
        } catch (e) {
          emit(CreateOrderFailure(
              messageError: 'Đã xảy ra lỗi không mong muốn'));
        }
      },
      failure: (error) {
        emit(CreateOrderFailure(
            messageError: NetworkExceptions.getErrorMessage(error)));
      },
    );
  }

  Future<void> Submit() async {
    emit(CreateOrderLoading());
    // DateTime bookingFrom = DateTime(
    //   fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).year,
    //   fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).month,
    //   fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).day,
    // );
    // DateTime bookingTo = DateTime(
    //   fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).year,
    //   fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).month,
    //   fromDate.text.toDateFormat(AppDateFormat.dayMonthYear).day,
    // );
    final ApiResult<SuccessMessage> response =
        await repository.createLeaveRequest(
      employee_code: employeeChoose?.code ?? '',
      time_keeping_code: employeeChoose?.time_keeping_code ?? '',
      from_date: fromDate.text
          .toDateFormat(AppDateFormat.dayMonthYear)
          .toStringFormat(AppDateFormat.dayMonthYear),
      to_date: toDate.text
          .toDateFormat(AppDateFormat.dayMonthYear)
          .toStringFormat(AppDateFormat.dayMonthYear),
      // for_reasons:'',
      reasons: reason.text,
      holiday_status_id: '${selectedQuote.id}',
      hours: '0',
      for_reasons: '1',
      company: employeeChoose?.company_id?[1] ?? 'N/A',
      minutes: minutes.text,
    );
    response.when(success: (data) {
      try {
        SuccessMessage successMessage = data;

        emit(CreateOrderSuccess());
      } catch (e) {
        emit(CreateOrderFailure(messageError: 'Đã xảy ra lỗi không mong muốn'));
      }
      // emit(state);
    }, failure: (error) {
      emit(CreateOrderFailure(
          messageError:
              'Đã xảy ra lỗi không mong muốn, Vui lòng kiểm tra lại quỹ phép'));
    });
  }

  List<EmployeeInfo> listEmployee = [];
  EmployeeInfo? employeeChoose;
  getListEmployee() async {
    emit(CreateOrderLoading());
    AttendanceRequest request =
        AttendanceRequest(params: AttendanceModel(args: ["", "", "", ""]));
    ApiResult<ListEmployeeResponse> apiResult =
        await repository.getListEmployee(body: request);
    apiResult.when(
      success: (data) {
        try {
          listEmployee = data.result ?? [];
          if (!Utils.isEmptyArray(listEmployee)) {
            employeeChoose = listEmployee.first;
          }
          emit(GetEmployeeSuccess());
        } catch (e) {
          emit(CreateOrderFailure(
              messageError: 'Đã xảy ra lỗi không mong muốn'));
        }
      },
      failure: (error) {
        emit(CreateOrderFailure(
            messageError: NetworkExceptions.getErrorMessage(error)));
      },
    );
  }
}
