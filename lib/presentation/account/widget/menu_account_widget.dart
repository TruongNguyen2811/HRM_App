import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/utils/custom_theme.dart';

class MenuAccountWidget extends StatefulWidget {
  final String? prefixIcon;
  final String? title;
  final String? suffixIcon;
  final bool showArrow;
  final bool showSwitch;
  final bool? valueSwitch;
  final bool showDivider;
  final Color? iconColor;
  final Function(bool)? onChangeSwitch;
  final VoidCallback? onTap;

  const MenuAccountWidget(
      {super.key,
      this.prefixIcon,
      this.title,
      this.suffixIcon,
      this.showArrow = true,
      this.onTap,
      this.showSwitch = false,
      this.valueSwitch,
      this.onChangeSwitch,
      this.iconColor,
      this.showDivider = true});

  @override
  State<MenuAccountWidget> createState() => _MenuAccountWidgetState();
}

class _MenuAccountWidgetState extends State<MenuAccountWidget> {
  // late bool _valueSwitch;

  @override
  void initState() {
    super.initState();
    // _valueSwitch = widget.valueSwitch ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap?.call();
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (widget.prefixIcon != null) ...[
                        Image.asset(
                          widget.prefixIcon!,
                          width: 24.w,
                          height: 24.w,
                          color: widget.iconColor ?? AppColors.primaryColor2,
                        ),
                        8.horizontalSpace,
                      ],
                      Expanded(
                        child: Text(widget.title ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .subTitle14
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.lightGray),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                      ),
                    ],
                  ),
                ),
                Text(widget.suffixIcon ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .textRegular
                        .copyWith(fontSize: 15.sp, color: AppColors.lightGray)),
                if (widget.showArrow && !widget.showSwitch)
                  Icon(
                    Icons.arrow_forward,
                    size: 16.w,
                    color: AppColors.lightGray,
                  ),
                if (!widget.showArrow && widget.showSwitch)
                  Container(
                    height: 24.h,
                    width: 48.w,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CupertinoSwitch(
                          value: widget.valueSwitch ?? false,
                          activeColor: AppColors.primaryColor2,
                          onChanged: (bool value) async {
                            await widget.onChangeSwitch?.call(value);
                          }),
                    ),
                  )
              ],
            ),
          ),
          if (widget.showDivider)
            const Divider(
              color: AppColors.dark9,
            )
        ],
      ),
    );
  }
}
