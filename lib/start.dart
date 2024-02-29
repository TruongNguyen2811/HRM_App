// import 'package:alice/alice.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrm/app.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/utils/logger.dart';
import 'package:timeago/timeago.dart' as timeago;

// Alice alice = Alice();

Future<void> start() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  timeago.setDefaultLocale("en");
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    // ignore: deprecated_member_use
    runApp(const App());
    // BlocOverrides.runZoned(
    //   () {
    //     if (!kDebugMode) {
    //       debugPrint = (message, {wrapWidth}) {};
    //     }

    //     runApp(App());
    //   },
    //   blocObserver: SimpleBlocObserver(),
    // );
  });
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.i('${bloc.runtimeType} $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('${bloc.runtimeType} $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i('$transition');
  }
}
