import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hrm/main.dart';
import 'package:hrm/presentation/authentication/authentication_state.dart';
import 'package:hrm/presentation/home/home_page.dart';
import 'package:hrm/start.dart';
import 'package:hrm/utils/enum.dart';
import 'package:hrm/utils/logger.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/utils/utils.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'configuration/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/authentication/authentication_cubit.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final AppCubit _authenticationCubit = GetIt.I<AppCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authenticationCubit.openApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // Design size
        builder: (context, child) => RefreshConfiguration(
          headerBuilder: () => const WaterDropMaterialHeader(),
          // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
          footerBuilder: () => const ClassicFooter(
            loadStyle: LoadStyle.HideAlways,
          ),
          child: MaterialApp(
            title: "HRM app",
            // navigatorKey: alice.getNavigatorKey(),
            theme: ThemeData(
                primaryColor: AppColors.primaryColor,
                brightness: Brightness.light,
                scaffoldBackgroundColor: AppColors.white,
                dialogBackgroundColor: AppColors.white,
                textTheme:
                    GoogleFonts.interTextTheme(Theme.of(context).textTheme),
                sliderTheme: Theme.of(context).sliderTheme.copyWith(
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 0),
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 6),
                    activeTrackColor: AppColors.textBlue,
                    inactiveTrackColor: AppColors.grey300,
                    thumbColor: const Color(0xFF6476D7),
                    tickMarkShape:
                        const RoundSliderTickMarkShape(tickMarkRadius: 4),
                    inactiveTickMarkColor: const Color(0xFFC4C4C4),
                    activeTickMarkColor: const Color(0xFF6476D7)),
                dividerColor: AppColors.lineGray,
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: AppColors.black)
                    .copyWith(background: AppColors.white)
                    .copyWith(secondary: AppColors.accentColor)),
            builder: (context, widget) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: widget!);
            },
            home: child,
          ),
        ),
        child: BlocProvider<AppCubit>(
          child: BlocConsumer<AppCubit, AppState>(
            listener: (context, state) {
              if (state is ErrorState) {
                Utils.showToast(context, state.error, type: ToastType.ERROR);
              }
              if (state is MessageState) {
                Utils.showToast(context, state.message,
                    type: state.messageType);
              }
              if (state is AuthenticationUnauthenticated) {
                if (!Utils.isEmpty(state.errorMessage)) {
                  Utils.showToast(context, state.errorMessage,
                      type: ToastType.ERROR);
                }
                try {
                  NavigationUtils.popToFirst(context);
                } catch (e) {
                  logger.e(e);
                }
              }
            },
            builder: (context, state) {
              // return const HomePage();
              if (state is AuthenticationUninitialized) {
                return const HomePage();
                // SPLASH
              }
              if (state is AuthenticationUnauthenticated) {
                return const MyHomePage(title: 'Flutter Demo Home Page');
              }
              if (state is AuthenticationAuthenticated) {
                return const MyHomePage(title: 'Flutter Demo Home Page');
              }
              return const MyHomePage(title: 'Flutter Demo Home Page');
            },
          ),
          create: (context) => _authenticationCubit,
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {}
    if (state == AppLifecycleState.paused) {
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    }
    super.didChangeAppLifecycleState(state);
  }
}
