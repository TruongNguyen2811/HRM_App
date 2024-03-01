import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../start.dart';

import '../../injection_container.dart';
import '../../services/repository/app_repository_impl.dart';
import '../../utils/logger.dart';

// import 'package:package_info_plus/package_info_plus.dart';

import 'main_state.dart';

@LazySingleton()
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();

  bool get isLoggedIn => _pref.isLoggedIn;
  int prePosition = 0;

  //Logic for override popup new appointment
  bool shouldPopAppointmentPage = false;
  String? pageOverrideAppointmentPage;
  void selectTab(int position) {
    if (prePosition == position) return;
    prePosition = position;
    emit(MainLoading());
    emit(MainNavigationState(position));
  }

  refreshAllTab() {
    emit(MainLoading());
    emit(MainRefreshAllTabState());
  }

  void refreshAuth() {
    emit(MainLoading());
    emit(MainRefreshAuthState());
  }

  void refreshOnlyMainState() {
    emit(MainLoading());
    emit(MainInitial());
  }

  logout() {
    emit(MainLoading());
    selectTab(0);
    emit(MainRefreshAllTabState());
  }
}
