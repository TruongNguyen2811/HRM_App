import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/widget/flux_image.dart';
import 'package:hrm/widget/single_tap.dart';

class ButtonServiceWidgetV2 extends StatefulWidget {
  final String? icon;
  final VoidCallback? onCallBack;
  final Gradient? bgColor;
  final String label;
  final double? iconW;
  final double? iconH;
  final double? width;
  final double? height;
  final double? boxWidth;
  final Color? labelColor;
  final Color? iconColor;
  final bool isNoColorBg;

  const ButtonServiceWidgetV2({
    Key? key,
    this.icon,
    this.onCallBack,
    this.bgColor,
    required this.label,
    this.iconW,
    this.iconH,
    this.height,
    this.width,
    this.labelColor,
    this.iconColor,
    this.isNoColorBg = false,
    this.boxWidth,
  }) : super(key: key);

  @override
  _ButtonServiceWidgetState createState() => _ButtonServiceWidgetState();
}

class _ButtonServiceWidgetState extends State<ButtonServiceWidgetV2> {
  @override
  Widget build(BuildContext context) {
    return SingleTapDetector(
      onTap: () {
        widget.onCallBack?.call();
      },
      child: SizedBox(
        width: widget.boxWidth,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                width: widget.width ?? 50.h,
                height: widget.height ?? 50.w,
                decoration: BoxDecoration(
                  gradient: !widget.isNoColorBg ? widget.bgColor : null,
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                ),
                child: FluxImage(
                  imageUrl: widget.icon ?? '',
                  width: widget.iconW ?? 50.w,
                  height: widget.iconH ?? 50.h,
                  color: widget.iconColor,
                )),
            8.verticalSpace,
            SizedBox(
              width: (widget.width ?? 1) * 1.5,
              child: Text(
                widget.label,
                style: Theme.of(context)
                    .textTheme
                    .text12W500
                    .copyWith(color: widget.labelColor ?? AppColors.dark1),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
