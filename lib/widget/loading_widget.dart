import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrm/configuration/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.overlayColor, this.overlayItem})
      : super(key: key);
  final Color? overlayColor;
  final Widget? overlayItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        overlayItem ??
            ModalBarrier(
              dismissible: false,
              color: overlayColor ?? Colors.black.withOpacity(0.3),
            ),
        Align(
          alignment: Alignment.center,
          child: SpinKitPouringHourGlassRefined(
            color: AppColors.primaryColor,
            size: 60.h,
          ),
        ),
      ],
    );
  }
}
