import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/model/request/login_request.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/services/api/api_result.dart';
import 'package:hrm/services/api/network_exceptions.dart';
import 'package:hrm/services/preferences/app_preference.dart';
// import 'package:hrm/injection_container.dart';
// import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/services/repository/app_repository_impl.dart';
// import 'package:hrm/utils/string_extension.dart';
import 'package:hrm/utils/utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AppRepository repository;
  final AppPreferences _pref = getIt<AppPreferences>();

  AuthResponse authResponse = AuthResponse();
  LoginCubit({required this.repository}) : super(LoginInitial());
  bool isErrorEnable = false;
  String? contentError;
  bool isErrorPasswordEnable = false;
  String? contentPasswordError;

  checkFocus(String? value) {
    if (!Utils.isEmpty(value)) {
      isErrorEnable = false;
      emit(LoginInitial());
    }
  }

  checkUpdatePassword(String phoneNumber, String password) async {
    emit(LoginLoading());
    if (Utils.isEmpty(phoneNumber)) {
      contentError = 'Bạn cần nhập tên đăng nhập';
      isErrorEnable = true;
      emit(LoginInitial());
      return;
    }
    // if (!phoneNumber.isPhoneNoValid()) {
    //   contentError = 'Bạn cần nhập số điện thoại đúng định dạng';
    //   isErrorEnable = true;
    //   emit(LoginInitial());
    //   return;
    // }
    if (Utils.isEmpty(password)) {
      contentPasswordError = 'Bạn cần nhập mật khẩu';
      isErrorPasswordEnable = true;
      emit(LoginInitial());
      return;
    }
    LoginRequest request =
        LoginRequest(params: BodyLogin(login: phoneNumber, password: password));
    ApiResult<AuthResponse> apiResult = await repository.login(body: request);
    apiResult.when(
      success: (data) {
        try {
          authResponse = data;
          _pref.saveAuthToken(authResponse.data);
          _pref.saveUserProfile(authResponse.data);
          emit(LoginSuccess());
        } catch (e) {
          emit(LoginFailure(messageError: 'Đã xảy ra lỗi không mong muốn'));
        }

        // try{
        //   authResponse = parseData(data);
        // _pref.saveAuthToken(data);
        // emit(LoginSuccess());
        // }catch(e){

        // }
      },
      failure: (error) {
        emit(LoginFailure(
            messageError:
                'Tài khoản hoặc mật khẩu không đúng, vui lòng kiểm tra lại'));
      },
    );

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
