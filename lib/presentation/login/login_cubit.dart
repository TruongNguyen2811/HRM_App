import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/services/repository/app_repository_impl.dart';
import 'package:hrm/utils/string_extension.dart';
import 'package:hrm/utils/utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AppRepository repository;
  final AppPreferences _pref = getIt<AppPreferences>();

  LoginCubit({required this.repository}) : super(LoginInitial());
  bool isErrorEnable = false;
  String? contentError;

  checkFocus(String? value) {
    if (!Utils.isEmpty(value)) {
      isErrorEnable = false;
      emit(LoginInitial());
    }
  }

  checkUpdatePassword(String phoneNumber) async {
    emit(LoginLoading());
    // if (Utils.isEmpty(phoneNumber)) {
    //   contentError = 'Bạn cần nhập số điện thoại';
    //   isErrorEnable = true;
    //   emit(LoginInitial());
    //   return;
    // }
    // if (!phoneNumber.isPhoneNoValid()) {
    //   contentError = 'Bạn cần nhập số điện thoại đúng định dạng';
    //   isErrorEnable = true;
    //   emit(LoginInitial());
    //   return;
    // }
    // else {
    emit(LoginPhoneNotUpdatePassword());
    // }

    // final ApiResult<bool?> apiResult =
    //     await repository.isUpdatePassword(userName: phoneNumber);
    // return apiResult.when(success: (bool? data) {
    //   if (data == true) {
    //     emit(LoginPhoneIsUpdatePassword());
    //     return;
    //   }
    //   if (data == false) {
    //     emit(LoginPhoneNotUpdatePassword());
    //     return;
    //   }
    // }, failureNet: (NetworkExceptions error) {
    //   emit(
    //       LoginFailure(messageError: NetworkExceptions.getErrorMessage(error)));
    // }, failureApi: (String error) {
    //   emit(LoginFailure(messageError: error));
    // }
    // );
  }
}
