import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/presentation/booking_room/booking_room_page.dart';
import 'package:hrm/presentation/list_booking/list_booking_cubit.dart';
import 'package:hrm/presentation/list_booking/list_booking_state.dart';
import 'package:hrm/presentation/list_booking/widget/booking_info.dart';
import 'package:hrm/utils/custom_gradient.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/button_widget.dart';
import 'package:hrm/widget/new_appbar_widget.dart';
import 'package:hrm/widget/show_loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListBookingPage extends StatefulWidget {
  const ListBookingPage({super.key});

  @override
  State<ListBookingPage> createState() => _ListBookingPageState();
}

class _ListBookingPageState extends State<ListBookingPage> {
  late ListBookingCubit _cubit;
  late RefreshController _refreshController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = ListBookingCubit();
    _cubit.getListBookingRoom();
    _refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListBookingCubit, ListBookingState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ListBookingFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
        },
        builder: (BuildContext context, ListBookingState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, ListBookingState state) {
    return ShowLoadingWidget(
      isLoading: state is ListBookingLoading,
      child: Scaffold(
        backgroundColor: AppColors.newBackgroundColor,
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const NewAppBarWidget(
            title: 'Danh sách đơn đặt phòng họp',
          ),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                _cubit.getListBookingRoom();
                _refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                  child: Utils.isEmptyArray(_cubit.listBooking)
                      ? _emptyWidget()
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 16.w),
                          itemBuilder: (context, index) {
                            return BookingInfoWidget(
                              item: _cubit.listBooking[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 8.h,
                            );
                          },
                          itemCount: _cubit.listBooking.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        )),
            ),
          )
        ]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 12,
                offset: Offset(0, -4),
                spreadRadius: 0,
              )
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: ButtonWidget(
            title: "Đặt phòng họp",
            gradient: mainGradientPrimary(),
            onPressed: () {
              NavigationUtils.rootNavigatePage(context, BookingRoomPage())
                  .then((value) {
                _cubit.getListBookingRoom();
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _emptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          150.verticalSpace,
          Image.asset(
            'assets/icon/ic_no_result.png',
            height: 140.w,
            width: 140.w,
          ),
          16.verticalSpace,
          Text(
            'Không tìm thấy kết quả',
            style: Theme.of(context)
                .textTheme
                .text16w500
                .copyWith(color: AppColors.dark7),
          ),
          100.verticalSpace,
        ],
      ),
    );
  }
}
