import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/utils/local_auth.dart';
import 'package:hrm/widget/single_tap.dart';
import 'package:local_auth/local_auth.dart';

class BioWidget extends StatefulWidget {
  final VoidCallback? onTap;
  final double? height;
  final bool enable;
  final List<BiometricType> biometrics;

  const BioWidget(
      {super.key,
      this.onTap,
      this.height,
      required this.enable,
      required this.biometrics});

  @override
  State<BioWidget> createState() => _BioWidgetState();
}

class _BioWidgetState extends State<BioWidget> {
  late final AppPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _preferences = getIt<AppPreferences>();
  }

  @override
  Widget build(BuildContext context) {
    return _preferences.getBioConfig && widget.enable
        ? IntrinsicWidth(
            child: SingleTapDetector(
              onTap: () async {
                final isAuth = await LocalAuthApi.authenticate();
                if (isAuth) {
                  widget.onTap?.call();
                }
              },
              child: _iconWidget(),
            ),
          )
        : SizedBox.shrink();
  }

  Widget _iconWidget() {
    if (widget.biometrics.contains(BiometricType.fingerprint)) {
      return Container(
        height: widget.height ?? 48.h,
        width: widget.height ?? 48.h,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(16.r)),
        child: Image.asset(
          'assets/icon/fingerprint.png',
          width: 28.w,
          height: 32.w,
          color: AppColors.white,
        ),
      );
    }
    if (widget.biometrics.contains(BiometricType.face)) {
      return Container(
        height: widget.height ?? 48.h,
        width: widget.height ?? 48.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(16.r)),
        child: Image.asset(
          'assets/icon/fingerprint.png',
          width: 32.w,
          height: 32.w,
          color: AppColors.white,
        ),
      );
    }
    return SizedBox.shrink();
  }
}
