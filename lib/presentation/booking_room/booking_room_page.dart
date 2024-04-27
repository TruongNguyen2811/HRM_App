import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/model/response/employee_info_response.dart';
import 'package:hrm/model/response/room_info_response.dart';
import 'package:hrm/presentation/booking_room/booking_room_cubit.dart';
import 'package:hrm/presentation/booking_room/booking_room_state.dart';
import 'package:hrm/presentation/create_order/order_type/order_type_page.dart';
import 'package:hrm/utils/custom_gradient.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/date_extension.dart';
import 'package:hrm/utils/enum.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/utils/utils.dart';
import 'package:hrm/widget/button_widget.dart';
import 'package:hrm/widget/dropdown_widget.dart';
import 'package:hrm/widget/new_appbar_widget.dart';
import 'package:hrm/widget/new_time_picker_widget.dart';
import 'package:hrm/widget/search_list_item.dart';
import 'package:hrm/widget/show_loading_widget.dart';
import 'package:hrm/widget/single_tap.dart';
import 'package:hrm/widget/text_field_date_widget.dart';
import 'package:hrm/widget/text_field_widget.dart';

class BookingRoomPage extends StatefulWidget {
  const BookingRoomPage({super.key});

  @override
  State<BookingRoomPage> createState() => _BookingRoomPageState();
}

class _BookingRoomPageState extends State<BookingRoomPage> {
  late BookingRoomCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    _cubit = BookingRoomCubit();
    _cubit.getListRoom();
    _cubit.getListEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingRoomCubit, BookingRoomState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is BookingRoomFailure) {
            Utils.showToast(context, state.messageError);
            return;
          }
          if (state is BookingRoomSuccess) {
            Utils.showToast(context, 'Bạn đã đặt phòng họp thành công',
                type: ToastType.SUCCESS);
            NavigationUtils.popPage(context);
          }
        },
        builder: (BuildContext context, BookingRoomState state) {
          return _buildPage(context, state);
        });
  }

  Widget _buildPage(BuildContext context, BookingRoomState state) {
    return ShowLoadingWidget(
      isLoading: state is BookingRoomLoading,
      child: KeyboardDismissOnTap(
        child: Scaffold(
          backgroundColor: AppColors.newBackgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NewAppBarWidget(
                title: 'Đặt phòng họp',
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        16.verticalSpace,
                        8.verticalSpace,
                        DropDownFieldWidget(
                          borderRadius: 16.r,
                          isEnable: true,
                          titleText: 'Nhân viên',
                          require: true,
                          hintText: 'Vui lòng chọn nhân viên',
                          value: _cubit.employeeChoose?.name,
                          // colorRequired: false,
                          // textStyle: Theme.of(context).textTheme.subTitle.copyWith(
                          // color: Utils.isEmpty(_cubit.cityChoose)
                          //     ? AppColors.enableButton: AppColors.dark1),
                          onClick: (currentValue) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (Utils.isEmptyArray(_cubit.listEmployee)) return;
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r)),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  final int? defaultIndex = _cubit.listEmployee
                                      ?.indexWhere((element) =>
                                          element.id ==
                                          _cubit.employeeChoose?.id);

                                  print(defaultIndex);
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child:
                                        SearchListSimpleItemPopup<EmployeeInfo>(
                                      listData: _cubit.listEmployee,
                                      title: 'Chọn nhân viên',
                                      showSearch: false,
                                      isShowButton: false,
                                      // pressSearch: true,
                                      defaultIndexes: defaultIndex != null &&
                                              defaultIndex >= 0
                                          ? [defaultIndex]
                                          : null,
                                      onSelect: (List<int> indexes) {
                                        print('check select');
                                        if (Utils.isEmptyArray(indexes)) {
                                          _cubit.chooseEmployee(null);

                                          return;
                                        } else {
                                          _cubit.chooseEmployee(_cubit
                                              .listEmployee[indexes.first]);
                                        }
                                        // NavigationUtils.popPage(context);
                                      },
                                      builder: (item) => item.name ?? '',
                                    ),
                                  );
                                });
                          },
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Text(
                              'Ngày đặt',
                              style: Theme.of(context)
                                  .textTheme
                                  .text14W400
                                  .copyWith(color: AppColors.dark3),
                            ),
                            Text(
                              '*',
                              style: Theme.of(context)
                                  .textTheme
                                  .text14W400
                                  .copyWith(color: AppColors.red),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        TextFieldDateWidget(
                          controller: _cubit.fromDate,
                          hintText: 'Chọn thời gian bắt đầu',
                        ),
                        8.verticalSpace,
                        DropDownFieldWidget(
                          borderRadius: 16.r,
                          isEnable: true,
                          titleText: 'Phòng họp',
                          require: true,
                          hintText: 'Vui lòng chọn phòng họp',
                          value: _cubit.infoRoomChoose?.name,
                          // colorRequired: false,
                          // textStyle: Theme.of(context).textTheme.subTitle.copyWith(
                          // color: Utils.isEmpty(_cubit.cityChoose)
                          //     ? AppColors.enableButton: AppColors.dark1),
                          onClick: (currentValue) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (Utils.isEmptyArray(_cubit.listRoom)) return;
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r)),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  final int? defaultIndex = _cubit.listRoom
                                      ?.indexWhere((element) =>
                                          element.id ==
                                          _cubit.infoRoomChoose?.id);

                                  print(defaultIndex);
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: SearchListSimpleItemPopup<InfoRoom>(
                                      listData: _cubit.listRoom,
                                      title: 'Chọn nhân viên',
                                      showSearch: false,
                                      isShowButton: false,
                                      // pressSearch: true,
                                      defaultIndexes: defaultIndex != null &&
                                              defaultIndex >= 0
                                          ? [defaultIndex]
                                          : null,
                                      onSelect: (List<int> indexes) {
                                        print('check select');
                                        if (Utils.isEmptyArray(indexes)) {
                                          _cubit.chooseRoom(null);

                                          return;
                                        } else {
                                          _cubit.chooseRoom(
                                              _cubit.listRoom[indexes.first]);
                                        }
                                        // NavigationUtils.popPage(context);
                                      },
                                      builder: (item) => item.name ?? '',
                                    ),
                                  );
                                });
                          },
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Text(
                              'Giờ bắt đầu',
                              style: Theme.of(context)
                                  .textTheme
                                  .text14W400
                                  .copyWith(color: AppColors.dark3),
                            ),
                            Text(
                              '*',
                              style: Theme.of(context)
                                  .textTheme
                                  .text14W400
                                  .copyWith(color: AppColors.red),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        Container(
                          height: 48.h,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r)),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return NewPickerTimeWidget(
                                    initData: _cubit.bookingTimeFrom.toString(),
                                    title: 'Chọn thời gian bắt đầu',
                                    titleButton: 'Xác nhận',
                                    onSelectedTime: (timer) {
                                      NavigationUtils.popDialog(context);
                                      _cubit.setTime(timer);
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(color: AppColors.dark9),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _cubit.bookingTimeFrom.hour.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subTitle
                                        .copyWith(color: AppColors.dark1),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    color: AppColors.dark1,
                                    height: 18.h,
                                    width: 1.w,
                                  ),
                                  Text(
                                    _cubit.bookingTimeFrom.minute < 10
                                        ? '0${_cubit.bookingTimeFrom.minute}'
                                        : _cubit.bookingTimeFrom.minute
                                            .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subTitle
                                        .copyWith(color: AppColors.dark1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Text(
                              'Giờ kết thúc',
                              style: Theme.of(context)
                                  .textTheme
                                  .text14W400
                                  .copyWith(color: AppColors.dark3),
                            ),
                            Text(
                              '*',
                              style: Theme.of(context)
                                  .textTheme
                                  .text14W400
                                  .copyWith(color: AppColors.red),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        Container(
                          height: 48.h,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r)),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return NewPickerTimeWidget(
                                    initData: _cubit.bookingTimeTo.toString(),
                                    // .toStringFormat(AppDateFormat
                                    //     .dayMonthYearHourMinuteSecond),
                                    title: 'Chọn thời gian bắt đầu',
                                    titleButton: 'Xác nhận',
                                    onSelectedTime: (timer) {
                                      NavigationUtils.popDialog(context);
                                      _cubit.setTimeTo(timer);
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(color: AppColors.dark9),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _cubit.bookingTimeTo.hour.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subTitle
                                        .copyWith(color: AppColors.dark1),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    color: AppColors.dark1,
                                    height: 18.h,
                                    width: 1.w,
                                  ),
                                  Text(
                                    _cubit.bookingTimeTo.minute < 10
                                        ? '0${_cubit.bookingTimeTo.minute}'
                                        : _cubit.bookingTimeTo.minute
                                            .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subTitle
                                        .copyWith(color: AppColors.dark1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Text(
                              'Mục đích',
                              style: Theme.of(context)
                                  .textTheme
                                  .text14W400
                                  .copyWith(color: AppColors.dark3),
                            ),
                            Text(
                              '*',
                              style: Theme.of(context)
                                  .textTheme
                                  .text14W400
                                  .copyWith(color: AppColors.red),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        TextFieldWidget(
                          controller: _cubit.reason,
                          maxLength: 500,
                          maxLines: 4,
                          hintText: 'Mục đích',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              title: "Xác nhận",
              gradient: mainGradientPrimary(),
              onPressed: () {
                _cubit.Submit();
              },
            ),
          ),
        ),
      ),
    );
  }
}
