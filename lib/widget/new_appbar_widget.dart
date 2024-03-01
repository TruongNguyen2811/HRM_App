// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/widget/single_tap.dart';

class NewAppBarWidget extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? widgetCustom;
  final EdgeInsetsGeometry? padding;
  final Function()? pressBack;
  const NewAppBarWidget({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.widgetCustom,
    this.padding,
    this.pressBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ??
          EdgeInsets.only(
            top: 12.h + MediaQuery.of(context).padding.top,
            left: 16.w,
            right: 16.w,
            bottom: 12.h,
          ),
      color: AppColors.primaryColor,

      // decoration: const BoxDecoration(
      //   color: AppColors.primaryColor,
      // ),
      child: (widgetCustom != null)
          ? widgetCustom!
          : Row(
              children: [
                leading ??
                    SingleTapDetector(
                      onTap: () {
                        pressBack != null
                            ? pressBack?.call()
                            : NavigationUtils.popPage(context);
                      },
                      child: Image.asset('assets/icon/arrow_circle_left.png',
                          height: 24.h, width: 24.w),
                    ),
                Expanded(
                    child: Center(
                        child: Text(
                  title ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .text17
                      .copyWith(color: AppColors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ))),
                actions != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: actions ?? [],
                      )
                    : 24.horizontalSpace,
              ],
            ),
    );
  }
}
