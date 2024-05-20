import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/response/employee_info_response.dart';
import 'package:hrm/model/response/kpi_response.dart';
import 'package:hrm/presentation/kpi/kpi_state.dart';
import 'package:hrm/services/api/api_result.dart';
import 'package:hrm/services/api/network_exceptions.dart';
import 'package:hrm/utils/utils.dart';
// import 'package:hrm/services/preferences/app_preference.dart';
// import '../../injection_container.dart';
import '../../services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class KPICubit extends Cubit<KPIState> {
  KPICubit() : super(KPIInitial());
  AppRepository repository = AppRepository();
  // final AppPreferences _pref = getIt<AppPreferences>();
  TextEditingController datePicker = TextEditingController();
  List<KPIResponse> kpiResponse = [];

  getKPIReport() async {
    emit(KPILoading());
    String filter =
        '[["date" , "=" , "${DateTime.now().year}-${DateTime.now().month}-1"],["employee_code","=" ,"${employeeChoose?.code ?? ''}"]]';
    String query = '{*}';
    // AttendanceRequest request = AttendanceRequest(
    //     params: AttendanceModel(args: [
    //   '${datePicker.text.split('-')[0]}',
    //   '${datePicker.text.split('-')[1]}',
    //   'APG230316002'
    // ]));
    ApiResult<List<KPIResponse>?> apiResult =
        await repository.getKPIReport(query: query, filter: filter);
    apiResult.when(
      success: (data) {
        try {
          kpiResponse = data ?? [];

          emit(KPIGetDataSuccess());
        } catch (e) {
          emit(KPIFailure(messageError: 'Đã xảy ra lỗi không mong muốn'));
        }
      },
      failure: (error) {
        emit(
            KPIFailure(messageError: NetworkExceptions.getErrorMessage(error)));
      },
    );
  }

  List<EmployeeInfo> listEmployee = [];
  EmployeeInfo? employeeChoose;
  getListEmployee() async {
    emit(KPILoading());
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
          emit(KPIFailure(messageError: 'Đã xảy ra lỗi không mong muốn'));
        }
      },
      failure: (error) {
        emit(
            KPIFailure(messageError: NetworkExceptions.getErrorMessage(error)));
      },
    );
  }
}
