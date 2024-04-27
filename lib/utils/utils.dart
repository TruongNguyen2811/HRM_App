import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/enum.dart';

class Utils {
  static bool isEmpty(Object? text) {
    if (text is String) return text.isEmpty;
    if (text is List) return text.isEmpty;
    return text == null;
  }

  static bool isEmptyArray(List? list) {
    return list == null || list.isEmpty;
  }

  static void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  static String convertVNtoText(String str) {
    str = str.replaceAll(RegExp(r'[à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ]'), 'a');

    str = str.replaceAll(RegExp(r'[è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ]'), 'e');
    str = str.replaceAll(RegExp(r'[ì|í|ị|ỉ|ĩ]'), 'i');
    str = str.replaceAll(RegExp(r'[ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ]'), 'o');
    str = str.replaceAll(RegExp(r'[ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ]'), 'u');
    str = str.replaceAll(RegExp(r'[ỳ|ý|ỵ|ỷ|ỹ]'), 'y');
    str = str.replaceAll(RegExp(r'[đ]'), 'd');

    str = str.replaceAll(RegExp(r'[À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ]'), 'A');
    str = str.replaceAll(RegExp(r'[È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ]'), 'E');
    str = str.replaceAll(RegExp(r'[Ì|Í|Ị|Ỉ|Ĩ]'), 'I');
    str = str.replaceAll(RegExp(r'[Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ]'), 'O');
    str = str.replaceAll(RegExp(r'[Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ]'), 'U');
    str = str.replaceAll(RegExp(r'[Ỳ|Ý|Ỵ|Ỷ|Ỹ]'), 'Y');
    str = str.replaceAll(RegExp(r'[Đ]'), 'D');
    return str;
  }

  static void showToast(BuildContext context, String? text,
      {ToastType? type = ToastType.ERROR, bool? isPrefixIcon = true}) {
    Color backgroundColor = AppColors.blue11;
    Color iconColor = AppColors.inform1;
    Color textColor = AppColors.neutral2;
    if (type == ToastType.WARNING) {
      iconColor = AppColors.orange;
      backgroundColor = AppColors.bgWarning;
    } else if (type == ToastType.SUCCESS) {
      iconColor = AppColors.success1;
      backgroundColor = AppColors.bgSuccess;
    } else if (type == ToastType.INFORM) {
      iconColor = AppColors.blue;
      backgroundColor = AppColors.bgInform;
    } else if (type == ToastType.ERROR) {
      iconColor = AppColors.danger1;
      backgroundColor = AppColors.bgWarning;
    }
    onWidgetDidBuild(() {
      FToast fToast = FToast();
      fToast.init(context);
      fToast.removeQueuedCustomToasts();
      Widget toast = Container(
        width: 1.sw,
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), color: backgroundColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(text ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .subTitle
                      .copyWith(color: textColor)),
            ),
            // SizedBox(
            //   width: 8.w,
            // ),
            // GestureDetector(
            //   onTap: () => fToast.removeCustomToast(),
            //   child: Icon(
            //     CupertinoIcons.xmark,
            //     size: 16.h,
            //     color: textColor,
            //   ),
            // )
          ],
        ),
      );

      if (!Utils.isEmpty(text)) {
        fToast.showToast(
          child: toast,
          gravity: ToastGravity.TOP,
          positionedToastBuilder: (context, child) {
            return Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: child,
            );
          },
          toastDuration: const Duration(seconds: 3),
        );
      }
    });
  }

  // Future<void> uint8ListToFile(Uint8List uint8list) async {
  //   // Lấy thư mục ứng dụng tạm thời
  //   Directory appDocDir = await getTemporaryDirectory();
  //   String appDocPath = appDocDir.path;

  //   // Tạo tệp tin với tên ngẫu nhiên
  //   String filePath =
  //       '$appDocPath/file_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //   File file = File(filePath);

  //   // Ghi dữ liệu từ Uint8List vào tệp tin
  //   await file.writeAsBytes(uint8list, flush: true);
  // }
}
