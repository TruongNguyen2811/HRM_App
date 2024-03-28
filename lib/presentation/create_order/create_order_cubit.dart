import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/presentation/create_order/create_order_state.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import '../../injection_container.dart';
import '../../services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CreateOrderInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();
  TextEditingController typeOrder = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController totalHours = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController reason = TextEditingController();
  void Submit() {
    emit(CreateOrderSuccess());
  }
}
