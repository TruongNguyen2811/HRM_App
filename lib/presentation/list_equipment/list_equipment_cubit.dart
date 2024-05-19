import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/model/request/attendance_request.dart';
import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/model/response/list_equipment_response.dart';
import 'package:hrm/presentation/list_equipment/list_equipment_state.dart';
import 'package:hrm/services/api/api_result.dart';
import 'package:hrm/services/api/network_exceptions.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class ListEquipmentCubit extends Cubit<ListEquipmentState> {
  ListEquipmentCubit() : super(ListEquipmentInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();

  bool get isLoggedIn => _pref.isLoggedIn;

  ProfileAuthResponse profileAuthResponse = ProfileAuthResponse();
  int prePosition = 0;
  getData() {
    profileAuthResponse = _pref.userProfile ?? ProfileAuthResponse();
  }

  List<Equipment> listEquipment = [];

  getListEquipment() async {
    emit(ListEquipmentLoading());
    AttendanceRequest request = AttendanceRequest(
        params: AttendanceModel(args: ["", "", "", "", "", "", "", 1, 10]));
    ApiResult<ListEquipmentResponse> apiResult =
        await repository.getEquipmentList(body: request);
    apiResult.when(success: (data) {
      try {
        listEquipment = data.result ?? [];

        emit(ListEquipmentSuccess());
      } catch (e) {
        emit(ListEquipmentFailure(
            messageError: 'Đã xảy ra lỗi không mong muốn'));
      }
    }, failure: (NetworkExceptions error) {
      emit(ListEquipmentFailure(
          messageError: NetworkExceptions.getErrorMessage(error)));
    });
  }
}
