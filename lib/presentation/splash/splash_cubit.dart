import 'package:bloc/bloc.dart';
import 'package:hrm/presentation/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());
}
