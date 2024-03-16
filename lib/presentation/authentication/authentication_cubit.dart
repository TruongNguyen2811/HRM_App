import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/presentation/main/main_cubit.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:injectable/injectable.dart';

import '../../injection_container.dart';
import '../../services/repository/app_repository_impl.dart';
import '../../utils/enum.dart';
import 'authentication_state.dart';

@LazySingleton()
class AppCubit extends Cubit<AppState> {
  final AppPreferences _pref = getIt<AppPreferences>();
  AppRepository repository = AppRepository();

  bool get isLoggedIn => _pref.isLoggedIn;

  AppCubit() : super(AuthenticationUninitialized());

  void openApp() {
    emit(AuthenticationUninitialized());
    Future.delayed(
      const Duration(milliseconds: 3500),
      () {
        if (isLoggedIn) {
          emit(AuthenticationAuthenticated());
          return;
        }
        emit(const AuthenticationUnauthenticated());
      },
    );
  }

  void login() {
    emit(AuthenticationLoading());
    emit(AuthenticationAuthenticated());
  }

  void logout({String? errorMessage}) async {
    print('go to logout');
    emit(AuthenticationLoading());
    getIt<MainCubit>().logout();

    _pref.logout();
    emit(AuthenticationUnauthenticated(errorMessage: errorMessage));
  }

  void navigateResetToSignIn() {
    emit(AuthenticationLoading());
    emit(const AuthenticationUnauthenticated());
  }

  void showError(String error) {
    AppState currentState = state;
    emit(ErrorState(error: error));
    emit(currentState);
  }

  void showMessage(String message, {ToastType messageType = ToastType.INFORM}) {
    emit(MessageState(message, messageType));
    emit(AuthenticationInitial());
  }
}
