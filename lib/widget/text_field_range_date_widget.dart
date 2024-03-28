import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/date_extension.dart';
import 'package:hrm/utils/string_extension.dart';
import 'package:hrm/widget/text_field_widget.dart';

class TextFieldRangeDateWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(DateTime)? onSelectedDate;
  final FocusNode? focusNode;
  final VoidCallback? confirm;

  const TextFieldRangeDateWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.onSelectedDate,
    this.focusNode,
    this.confirm,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      focusNode: focusNode,
      readOnly: true,
      onTap: () async {
        final result = await showCalendarDatePicker2Dialog(
          context: context,
          config: CalendarDatePicker2WithActionButtonsConfig(
            firstDate: DateTime(1990),
            lastDate: DateTime.now(),
            currentDate: controller.text != ''
                ? controller.text.toDateFormat(AppDateFormat.dayMonthYear)
                : null,
            calendarType: CalendarDatePicker2Type.range,
            // nextMonthIcon: SvgPicture.asset(
            //   'assets/svg/ic_navigate_next.svg',
            //   width: 24.w,
            //   height: 24.h,
            //   colorFilter:
            //       const ColorFilter.mode(AppColors.dark11, BlendMode.srcIn),
            // ),
            // lastMonthIcon: SvgPicture.asset(
            //   'assets/svg/ic_navigate_before.svg',
            //   width: 24.w,
            //   height: 24.h,
            //   colorFilter:
            //       const ColorFilter.mode(AppColors.dark11, BlendMode.srcIn),
            // ),
            customModePickerIcon: SvgPicture.asset(
              'assets/svg/icon_calendar_down.svg',
              width: 18.w,
              height: 18.w,
              colorFilter:
                  const ColorFilter.mode(AppColors.dark5, BlendMode.srcIn),
            ),
            disabledDayTextStyle: Theme.of(context)
                .textTheme
                .subTitle16
                .copyWith(color: AppColors.dark5),
            dayTextStyle: Theme.of(context)
                .textTheme
                .text16w500
                .copyWith(color: AppColors.dark5),
            weekdayLabelTextStyle: Theme.of(context)
                .textTheme
                .body2
                .copyWith(color: AppColors.dark5),
            todayTextStyle: Theme.of(context)
                .textTheme
                .text16w500
                .copyWith(color: AppColors.black),
            yearTextStyle: Theme.of(context)
                .textTheme
                .text16w400
                .copyWith(color: AppColors.dark5),
            selectedRangeHighlightColor: AppColors.tabSelected,
            selectedDayTextStyle: Theme.of(context)
                .textTheme
                .text16w500
                .copyWith(color: AppColors.white),
            selectedYearTextStyle: Theme.of(context)
                .textTheme
                .text16w500
                .copyWith(color: AppColors.white),
            dayBorderRadius: BorderRadius.circular(8.r),
            selectedDayHighlightColor: AppColors.primaryColor,
            controlsTextStyle: Theme.of(context)
                .textTheme
                .text18W600
                .copyWith(color: AppColors.dark5),
            modePickerTextHandler: ({required monthDate}) {
              return 'Tháng ${monthDate.month}/${monthDate.year}';
            },
          ),
          dialogSize: const Size(325, 400),
          value: controller.text != ''
              ? [
                  controller.text
                      .split('-')[0]
                      .toDateFormat(AppDateFormat.dayMonthYear),
                  controller.text
                      .split('-')[1]
                      .toDateFormat(AppDateFormat.dayMonthYear)
                ]
              : [],
          borderRadius: BorderRadius.circular(12.r),
        );
        controller.text = (result?.isEmpty ?? true)
            ? controller.text
            : '${(result?.first).toString().toDateFormat(AppDateFormat.yearMonthDayHourMinuteSecondSSS).toStringFormat(AppDateFormat.dayMonthYear)}-${(result?.last).toString().toDateFormat(AppDateFormat.yearMonthDayHourMinuteSecondSSS).toStringFormat(AppDateFormat.dayMonthYear)}';
        if (confirm != null) {
          confirm!();
        }
      },
      controller: controller,
      hintText: hintText,
      suffixIcon: 'assets/icon/ic_calendar_outline.png',
      suffixColor: AppColors.dark5,
      // validator: (value) {

      // },
    );
  }
}
