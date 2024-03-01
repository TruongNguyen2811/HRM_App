// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import 'presentation/authentication/authentication_cubit.dart' as _i3;
import 'presentation/main/main_cubit.dart' as _i4;
import 'services/preferences/app_preference.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppCubit>(() => _i3.AppCubit());
  gh.lazySingleton<_i4.MainCubit>(() => _i4.MainCubit());
  await gh.factoryAsync<_i5.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i6.AppPreferences>(
      () => _i6.AppPreferences(get<_i5.SharedPreferences>()));
  return get;
}

class _$RegisterModule extends _i6.RegisterModule {}
