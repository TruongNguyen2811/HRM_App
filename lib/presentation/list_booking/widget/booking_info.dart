import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/model/response/list_booking_room_response.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/date_extension.dart';
import 'package:hrm/utils/string_extension.dart';

// ignore: must_be_immutable
class BookingInfoWidget extends StatelessWidget {
  BookingRoomInfo item;
  BookingInfoWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primaryColor)),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${item.employee?[1] ?? ''}',
              style: Theme.of(context).textTheme.buttonNormal.copyWith(),
            ),
            if (item.state == 'confirm') ...[
              Text(
                'Đã duyệt',
                style: Theme.of(context)
                    .textTheme
                    .text12w600
                    .copyWith(color: AppColors.success1),
              ),
            ] else ...[
              Text(
                'Chờ duyệt',
                style: Theme.of(context)
                    .textTheme
                    .text12w600
                    .copyWith(color: AppColors.danger1),
              ),
            ]
          ],
        ),
        4.verticalSpace,
        Row(
          children: [
            Text(
              'Phòng họp: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              '${item.room?[1] ?? 'N/A'}',
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          children: [
            Text(
              'Thời gian yêu cầu: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              "${item.req_date?.toDateFormatString(AppDateFormat.yearMonthDay, AppDateFormat.dayMonthYear) ?? ''}",
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          children: [
            Text(
              'Thời gian bắt đầu: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              "${item.date_from?.toDateFormatString(AppDateFormat.yearMonthDayHourMinuteSecondSSS, AppDateFormat.dayMonthYearHourMinute) ?? ''}",
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          children: [
            Text(
              'Thời gian kết thúc: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              "${item.date_to?.toDateFormatString(AppDateFormat.yearMonthDayHourMinuteSecondSSS, AppDateFormat.dayMonthYearHourMinute) ?? ''}",
              // '${item.date_to}',
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          children: [
            Text(
              'Mục đích: ',
              style: Theme.of(context).textTheme.text14W700.copyWith(),
            ),
            Text(
              '${item.purpose}',
              style: Theme.of(context).textTheme.text14W400.copyWith(),
            ),
          ],
        ),
        4.verticalSpace,
      ]),
    );
  }
}
