import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/presentation/home/home_state.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import '../../injection_container.dart';
import '../../services/repository/app_repository_impl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  AppRepository repository = AppRepository();
  final AppPreferences _pref = getIt<AppPreferences>();

  bool get isLoggedIn => _pref.isLoggedIn;
  int prePosition = 0;
  List<String> nextEvents = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTpKSTY82Nc6DVxmxV1BTqHcAB-dehXd9rmw&usqp=CAU',
    'https://images2.thanhnien.vn/Uploaded/tamkc/2023_01_14/gia-bitcoin-deu-tang-trong-ba-nam-sau-khi-hoi-nghi-dong-thuan-dien-ra2-4421.jpg',
    'https://file3.qdnd.vn/data/images/0/2021/12/02/tranyen/chungkhoan1.jpg?dpi=150&quality=100&w=870'
  ];
}
