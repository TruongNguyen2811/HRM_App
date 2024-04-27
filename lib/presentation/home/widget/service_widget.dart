import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/presentation/booking_room/booking_room_page.dart';
import 'package:hrm/presentation/create_order/create_order_page.dart';
import 'package:hrm/presentation/kpi/kpi_page.dart';
import 'package:hrm/presentation/main/main_cubit.dart';
import 'package:hrm/presentation/time_keeping/time_keeping_page.dart';
import 'package:hrm/utils/custom_gradient.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/widget/button_service_widget.dart';

class HomeMenuWidget extends StatefulWidget {
  const HomeMenuWidget({Key? key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenuWidget> {
  // final AuthenticationCubit _authCubit = GetIt.I<AuthenticationCubit>();
  // final AppPreferences _pref = getIt<AppPreferences>();
  final MainCubit mainCubit = getIt<MainCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ButtonServiceWidgetV2(
                    height: 48.h,
                    width: 48.w,
                    iconH: 30.h,
                    iconW: 30.w,
                    iconColor: AppColors.white,
                    icon: 'assets/icon/ic_timer.png',
                    label: 'Chấm công',
                    bgColor: sosLinnearGradientDarkBlue(),
                    onCallBack: () {
                      NavigationUtils.navigatePage(context, TimeKeepingPage());
                    }),
              ),
              Expanded(
                child: ButtonServiceWidgetV2(
                    height: 48.h,
                    width: 48.w,
                    iconH: 30.h,
                    iconW: 30.w,
                    iconColor: AppColors.white,
                    icon: 'assets/icon/ic_form.png',
                    label: 'Tạo đơn',
                    bgColor: sosLinnearGradientDarkBlue(),
                    onCallBack: () {
                      NavigationUtils.navigatePage(context, CreateOrderPage());
                    }),
              ),
              Expanded(
                child: ButtonServiceWidgetV2(
                    height: 48.h,
                    width: 48.w,
                    iconH: 28.h,
                    iconW: 28.w,
                    iconColor: AppColors.white,
                    icon: 'assets/icon/ic_booking.png',
                    label: 'Đặt phòng',
                    bgColor: sosLinnearGradientDarkBlue(),
                    onCallBack: () {
                      NavigationUtils.rootNavigatePage(
                          context, BookingRoomPage());
                    }),
              ),
              Expanded(
                child: ButtonServiceWidgetV2(
                    height: 48.h,
                    width: 48.w,
                    iconH: 28.h,
                    iconW: 28.w,
                    iconColor: AppColors.white,
                    icon: 'assets/icon/kpi.png',
                    label: 'Xem KPI',
                    bgColor: sosLinnearGradientDarkBlue(),
                    onCallBack: () {
                      NavigationUtils.rootNavigatePage(context, KpiPage());
                    }),
              ),
            ],
          ),
          20.verticalSpace,
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(
          //       child: ButtonServiceWidgetV2(
          //           height: 48.h,
          //           width: 48.w,
          //           iconH: 28.h,
          //           iconW: 28.w,
          //           iconColor: AppColors.white,
          //           icon: 'assets/icon/ic_salary.png',
          //           label: 'Bảng lương',
          //           bgColor: sosLinnearGradientDarkBlue(),
          //           onCallBack: () {}),
          //     ),
          //     Expanded(
          //       child: ButtonServiceWidgetV2(
          //           height: 48.h,
          //           width: 48.w,
          //           iconH: 28.h,
          //           iconW: 28.w,
          //           iconColor: AppColors.white,
          //           icon: 'assets/icon/ic_check-in.png',
          //           label: 'Danh sách đơn',
          //           bgColor: sosLinnearGradientDarkBlue(),
          //           onCallBack: () {}),
          //     ),
          //     Expanded(
          //       child: ButtonServiceWidgetV2(
          //           height: 48.h,
          //           width: 48.w,
          //           iconH: 28.h,
          //           iconW: 28.w,
          //           iconColor: AppColors.white,
          //           icon: 'assets/icon/ic_check-in.png',
          //           label: 'Phiếu khám',
          //           bgColor: sosLinnearGradientDarkBlue(),
          //           onCallBack: () {}),
          //     ),
          //     Expanded(
          //       child: ButtonServiceWidgetV2(
          //           height: 48.h,
          //           width: 48.w,
          //           iconH: 28.h,
          //           iconW: 28.w,
          //           iconColor: AppColors.white,
          //           icon: 'assets/icon/ic_check-in.png',
          //           label: 'Phiếu khám',
          //           bgColor: sosLinnearGradientDarkBlue(),
          //           onCallBack: () {}),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
