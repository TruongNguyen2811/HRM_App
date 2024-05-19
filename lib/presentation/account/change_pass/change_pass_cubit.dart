import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/model/response/success_message_response.dart';
import 'package:hrm/presentation/account/change_pass/change_pass_state.dart';
import 'package:hrm/services/api/api_result.dart';
import 'package:hrm/services/api/network_exceptions.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class ChangePassCubit extends Cubit<ChangePassState> {
  ChangePassCubit() : super(ChangePassInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();
  TextEditingController textEditingController = TextEditingController();

  bool get isLoggedIn => _pref.isLoggedIn;

  ProfileAuthResponse profileAuthResponse = ProfileAuthResponse();
  int prePosition = 0;
  getData() {
    profileAuthResponse = _pref.userProfile ?? ProfileAuthResponse();
  }

  changePass() async {
    emit(ChangePassLoading());
    AttendanceRequest request = AttendanceRequest(
        params: AttendanceModel(args: [
      profileAuthResponse.employee_id,
      textEditingController.text
    ]));
    ApiResult<SuccessMessage> apiResult =
        await repository.changePassWord(body: request);
    apiResult.when(
      success: (data) {
        try {
          emit(ChangePassSuccess());
        } catch (e) {
          emit(
              ChangePassFailure(messageError: 'Đã xảy ra lỗi không mong muốn'));
        }
      },
      failure: (error) {
        emit(ChangePassFailure(
            messageError: NetworkExceptions.getErrorMessage(error)));
      },
    );
  }
}
