import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hrm/presentation/authentication/authentication_cubit.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/widget/show_loading_widget.dart';
import '../../app.dart';
import '../../configuration/colors.dart';
import '../../injection_container.dart';
import '../../utils/enum.dart';
import '../../utils/logger.dart';
import '../../utils/navigation_utils.dart';
import '../../utils/utils.dart';

import 'main_cubit.dart';
import 'main_state.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with RouteAware, WidgetsBindingObserver {
  late MainCubit _cubit;
  late AppCubit _authCubit;
  // late HomeCubit _homeCubit;
  // late AccountCubit _accountCubit;
  final String localUserID = math.Random().nextInt(10000).toString();
  final AppPreferences _pref = getIt<AppPreferences>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _authCubit = GetIt.I<AppCubit>();
    _cubit = GetIt.I<MainCubit>();
    // _homeCubit = HomeCubit();
    // _accountCubit = AccountCubit();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _authCubit),
          BlocProvider.value(
            value: _cubit,
          ),
          // BlocProvider.value(
          //   value: _homeCubit,
          // ),
          // BlocProvider(
          //   create: (context) => _accountCubit,
          // ),
        ],
        child: BlocConsumer<MainCubit, MainState>(
          listener: (context, state) async {
            if (state is MainFailure) {
              Utils.showToast(context, state.error, type: ToastType.ERROR);
              return;
            }
            if (state is MainNavigationState) {
              _currentIndex = state.position;
              // _controller.jumpToTab(_currentIndex);
              return;
            }
            if (state is MainRefreshAuthState) {
              return;
            }
            if (state is CheckConnectionFailedState) {}
            if (state is MainRefreshAccountState) {}

            if (state is NavigationTabState) {
              return;
            }

            if (state is RefreshAllInappState) {}
            if (state is RefreshAllTabState) {}
          },
          builder: (context, state) {
            return _buildPage(state);
          },
        ),
      ),
    );
  }

  Widget _buildPage(MainState state) {
    return ShowLoadingWidget(
        isLoading: state is MainLoading,
        child: Scaffold(
          bottomNavigationBar: CircleNavBar(
            activeIndex: _currentIndex,
            activeIcons: const [
              Icon(Icons.home_filled, color: AppColors.white),
              Icon(Icons.dashboard_sharp, color: AppColors.white),
              Icon(Icons.account_circle_sharp, color: AppColors.white),
            ],
            inactiveIcons: [
              Text(
                "Trang chủ",
                style: Theme.of(context).textTheme.tooltip.copyWith(
                    color: AppColors.dark7, fontWeight: FontWeight.w500),
              ),
              Text(
                "Tiện ích",
                style: Theme.of(context).textTheme.tooltip.copyWith(
                    color: AppColors.dark7, fontWeight: FontWeight.w500),
              ),
              Text(
                "Tài khoản",
                style: Theme.of(context).textTheme.tooltip.copyWith(
                    color: AppColors.dark7, fontWeight: FontWeight.w500),
              ),
            ],
            color: Colors.white,
            circleColor: Colors.white,
            height: 60.h,
            circleWidth: 60.h,
            onTap: ((index) {
              _currentIndex = index;
              _cubit.selectTab(index);
            }),
            // tabCurve: ,
            // padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            cornerRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
              // bottomRight: Radius.circular(24),
              // bottomLeft: Radius.circular(24),
            ),
            shadowColor: AppColors.shadowColor,
            circleShadowColor: AppColors.shadowColor,
            elevation: 4,
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [AppColors.white, AppColors.white],
            ),
            circleGradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color.fromARGB(255, 29, 40, 65), AppColors.primaryColor],
            ),
          ),
        ));
  }

  List<Widget> _buildScreens() {
    return [
      // HomePage(),
      // DiscoveryPage(),
      // JobPage(),
      // AccountPage(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      //Check call when open app from background
      // _cubit.checkAndNavigationCallingPage();
    }
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    logger.i("didPush");
  }

  @override
  void didPop() {
    // Route was pushed onto navigator and is now topmost route.
    logger.i("didPop");
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    logger.i("didPopNext");
  }

  @override
  void didPushNext() {
    // Covering route was popped off the navigator.
    logger.i("didPushNext");
  }

  @override
  Future<bool> didPopRoute() {
    logger.i("didPopRoute");
    return super.didPopRoute();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    // _cubit.close();
    super.dispose();
  }
}
