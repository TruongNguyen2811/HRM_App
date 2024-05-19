import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configuration/colors.dart';

extension CustomTheme on TextTheme {
  TextStyle get titleLarge => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
      );

  TextStyle get title1 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get titleW300 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 32.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get title2 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get title6 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 28.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get title3 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get title4 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get title10 {
    return GoogleFonts.inter(
      color: AppColors.white,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get body1 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle get body1Bold => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      );

  TextStyle get body2Bold => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get body2 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle get buttonNormal => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle get subTitleRegular => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get tooltip => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle get labelLargeText => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle get labelNormalText => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle get h5Regular {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get subTitle {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get subTitleItalic {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontStyle: FontStyle.italic,
      fontSize: 14.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get textRegular => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle get smallNormal => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle get labelHighLight {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get labelHighLight2 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get h5Bold {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get subTitle12 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get subTitle14 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get subTitle16 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get text16 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get text16w400 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get text16w500 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get text17 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get text18 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 18.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get text20 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get text14 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 14.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get label14 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get labelDark14 {
    return GoogleFonts.inter(
      color: AppColors.black,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get labelDark16 {
    return GoogleFonts.inter(
      color: AppColors.black,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get labelDark20 {
    return GoogleFonts.inter(
      color: AppColors.black,
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get bold14 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get h4Bold {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get h3Bold {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get h6Bold {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get text12 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle get text10 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 10.sp,
        fontWeight: FontWeight.w300,
      );

  TextStyle get textSmall => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get title5 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      );

  TextStyle get content1 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
      );

  TextStyle get smallMedium => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get text28W700 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
      );

  TextStyle get subTextNoty {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get text14W400 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle get text14W500 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get text14W600 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );
  TextStyle get text14W700 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      );

  TextStyle get text28W600 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle get text36W500 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 36.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get text12W300 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w300,
      );

  TextStyle get text12W400 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle get text12W500 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get text18W500 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      );
  TextStyle get text18w600 {
    return GoogleFonts.inter(
      color: AppColors.dark1,
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get text18W600 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle get text10w400 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
      );
  TextStyle get text16w700 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      );
  TextStyle get text16w600 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle get text12w700 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      );

  TextStyle get text12w600 => GoogleFonts.inter(
        color: AppColors.dark1,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      );
}
