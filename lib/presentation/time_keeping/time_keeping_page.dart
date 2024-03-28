import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/model/response/attendance_response.dart';
import 'package:hrm/presentation/time_keeping/time_keeping_cubit.dart';
import 'package:hrm/presentation/time_keeping/time_keeping_state.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/date_extension.dart';
import 'package:hrm/utils/string_extension.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/new_appbar_widget.dart';
import 'package:hrm/widget/show_loading_widget.dart';
import 'package:hrm/widget/text_field_range_date_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TimeKeepingPage extends StatefulWidget {
  const TimeKeepingPage({super.key});

  @override
  State<TimeKeepingPage> createState() => _TimeKeepingState();
}

class _TimeKeepingState extends State<TimeKeepingPage> {
  late TimeKeepingCubit _cubit;
  late RefreshController refreshController;
  @override
  void initState() {
    // TODO: implement initState
    _cubit = TimeKeepingCubit();
    refreshController = RefreshController();
    super.initState();
    _cubit.datePicker.text =
        '${DateTime.now().toStringFormat(AppDateFormat.dayMonthYear)}-${DateTime.now().toStringFormat(AppDateFormat.dayMonthYear)}';
    _cubit.getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimeKeepingCubit, TimeKeepingState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is TimeKeepingFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
        },
        builder: (BuildContext context, TimeKeepingState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, TimeKeepingState state) {
    return ShowLoadingWidget(
      isLoading: state is TimeKeepingLoading,
      child: Scaffold(
        backgroundColor: AppColors.newBackgroundColor,
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          NewAppBarWidget(
            title: 'Chấm công',
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  color: AppColors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: TextFieldRangeDateWidget(
                    controller: _cubit.datePicker,
                    hintText: 'Chọn ngày ',
                    confirm: (() {
                      print('check confirm ${_cubit.datePicker.text}');
                      _cubit.getAttendance();
                    }),
                  ),
                ),
                8.verticalSpace,
                Container(
                    color: AppColors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(
                      children: [
                        Text(
                          'Danh sách chấm công',
                          style:
                              Theme.of(context).textTheme.text14W500.copyWith(),
                        ),
                      ],
                    )),
                Expanded(
                  child: Utils.isEmptyArray(_cubit.attendance)
                      ? _emptyWidget()
                      : SmartRefresher(
                          controller: refreshController,
                          onRefresh: () {
                            _cubit.getAttendance();
                            refreshController.refreshCompleted();
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _cubit.attendance.length,
                                  itemBuilder: ((context, index) {
                                    return TikeKeepingDetail(
                                        _cubit.attendance[index]);
                                  }),
                                ),
                                24.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget _emptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

  Widget TikeKeepingDetail(AttendanceResponse data) {
    return Container(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(
            'Ngày ${data.date?.toDateFormat(AppDateFormat.yearMonthDay).toStringFormat(AppDateFormat.dayMonthYear) ?? ''}',
            style: Theme.of(context)
                .textTheme
                .text14W600
                .copyWith(color: AppColors.primaryColor),
          ),
        ),
        if (!Utils.isEmpty(data.attendance_attempt_1)) ...[
          CheckIn(1, data.attendance_attempt_1 ?? '')
        ],
        if (!Utils.isEmpty(data.attendance_attempt_2)) ...[
          CheckOut(2, data.attendance_attempt_2 ?? '')
        ],
        if (!Utils.isEmpty(data.attendance_attempt_3)) ...[
          CheckIn(3, data.attendance_attempt_3 ?? '')
        ],
        if (!Utils.isEmpty(data.attendance_attempt_4)) ...[
          CheckOut(4, data.attendance_attempt_4 ?? '')
        ],
        // CheckOut(4),
      ]),
    );
  }

  Widget CheckIn(int index, String time) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      width: double.infinity,
      color: AppColors.white,
      child: Row(children: [
        16.horizontalSpace,
        Container(
          width: 4.w,
          height: 46.h,
          color: AppColors.green2,
        ),
        16.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lần chấm ${index}',
              style: Theme.of(context).textTheme.text14W600.copyWith(),
            ),
            6.verticalSpace,
            Row(
              children: [
                Text(
                  '${time.toDateFormat(AppDateFormat.yearMonthDayHourMinuteSecondSSS).toStringFormat(AppDateFormat.hourMinute)}',
                  style: Theme.of(context)
                      .textTheme
                      .text14W400
                      .copyWith(color: AppColors.dark7),
                ),
                4.horizontalSpace,
                Icon(
                  Icons.circle,
                  size: 6.w,
                  color: AppColors.dark7,
                ),
                4.horizontalSpace,
                Text(
                  'Vào',
                  style: Theme.of(context)
                      .textTheme
                      .text14W400
                      .copyWith(color: AppColors.dark7),
                ),
                4.horizontalSpace,
                Icon(
                  Icons.circle,
                  size: 6.w,
                  color: AppColors.dark7,
                ),
                4.horizontalSpace,
                Text(
                  'Đúng giờ',
                  style: Theme.of(context)
                      .textTheme
                      .text14W400
                      .copyWith(color: AppColors.green2),
                ),
              ],
            )
          ],
        )
      ]),
    );
  }

  Widget CheckOut(int index, String time) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      width: double.infinity,
      color: AppColors.white,
      child: Row(children: [
        16.horizontalSpace,
        Container(
          width: 4.w,
          height: 46.h,
          color: AppColors.primary1,
        ),
        16.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lần chấm ${index}',
              style: Theme.of(context).textTheme.text14W600.copyWith(),
            ),
            6.verticalSpace,
            Row(
              children: [
                Text(
                  '${time.toDateFormat(AppDateFormat.yearMonthDayHourMinuteSecondSSS).toStringFormat(AppDateFormat.hourMinute)}',
                  style: Theme.of(context)
                      .textTheme
                      .text14W400
                      .copyWith(color: AppColors.dark7),
                ),
                4.horizontalSpace,
                Icon(
                  Icons.circle,
                  size: 6.w,
                  color: AppColors.dark7,
                ),
                4.horizontalSpace,
                Text(
                  'Ra',
                  style: Theme.of(context)
                      .textTheme
                      .text14W400
                      .copyWith(color: AppColors.dark7),
                ),
                4.horizontalSpace,
                Icon(
                  Icons.circle,
                  size: 6.w,
                  color: AppColors.dark7,
                ),
                4.horizontalSpace,
                Text(
                  'Không đúng giờ',
                  style: Theme.of(context)
                      .textTheme
                      .text14W400
                      .copyWith(color: AppColors.primary1),
                ),
              ],
            )
          ],
        )
      ]),
    );
  }
}
