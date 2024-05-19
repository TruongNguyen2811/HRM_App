import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/presentation/account/account_state.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/utils/local_auth.dart';
import '../../injection_container.dart';
import '../../services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();

  bool get isLoggedIn => _pref.isLoggedIn;

  ProfileAuthResponse profileAuthResponse = ProfileAuthResponse();
  int prePosition = 0;
  getData() {
    profileAuthResponse = _pref.userProfile ?? ProfileAuthResponse();
  }

  logout() async {
    emit(AccountLoading());
    emit(AccountLogOutSuccess());
  }

  onCheckAuth() {
    emit(AccountInitial());
    checkBio = _pref.getBioConfig;
    emit(GetBioSuccess());
  }

  bool checkBio = false;
  onBioAuth() async {
    if (checkBio == false) {
      emit(AccountLoading());
      final isAuth = await LocalAuthApi.authenticate();
      if (isAuth) {
        checkBio = true;
        _pref.saveBioConfig(checkBio);
        emit(AcceptBioSuccess());
      } else {
        emit(RequestBio());
      }
    } else if (checkBio == true) {
      emit(AccountLoading());
      checkBio = false;
      _pref.saveBioConfig(checkBio);
      emit(DenyBioSuccess());
    }
  }
}
