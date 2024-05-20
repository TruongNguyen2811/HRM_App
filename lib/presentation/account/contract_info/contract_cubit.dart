import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/model/response/contract_response.dart';
import 'package:hrm/presentation/account/contract_info/contract_state.dart';
import 'package:hrm/services/api/api_result.dart';
import 'package:hrm/services/api/network_exceptions.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class ContractCubit extends Cubit<ContractState> {
  ContractCubit() : super(ContractInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();

  bool get isLoggedIn => _pref.isLoggedIn;

  ProfileAuthResponse profileAuthResponse = ProfileAuthResponse();
  int prePosition = 0;
  getData() {
    profileAuthResponse = _pref.userProfile ?? ProfileAuthResponse();
  }

  List<ContractInfo> listContract = [];

  getListContract() async {
    emit(ContractLoading());
    AttendanceRequest request = AttendanceRequest(
        params: AttendanceModel(args: ["", "", "", "", "", 1, 10, "", "", ""]));
    ApiResult<ListContractResponse> apiResult =
        await repository.getContractInfo(body: request);
    apiResult.when(success: (data) {
      try {
        listContract = data.result ?? [];
        print('check length ${listContract.length}');
        emit(ContractGetDataSuccess());
      } catch (e) {
        emit(ContractFailure(messageError: 'Đã xảy ra lỗi không mong muốn'));
      }
    }, failure: (NetworkExceptions error) {
      emit(ContractFailure(
          messageError: NetworkExceptions.getErrorMessage(error)));
    });
  }
}
