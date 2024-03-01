import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/injection_container.dart';
import 'package:hrm/services/preferences/app_preference.dart';
import 'package:hrm/widget/shimmer_widget.dart';
import 'package:hrm/widget/single_tap.dart';

class CustomCacheImageWidget extends StatelessWidget {
  final AppPreferences _pref = getIt<AppPreferences>();
  final String? imageUrl;
  final double size;
  final double? height;
  final double? width;
  final String? placeHolder;
  final bool isEnabled;
  final bool isCircle;
  final bool isGradientBorder;
  final VoidCallback? onPickImage;
  final double? radius;
  final BorderRadius? borderRadius;
  final VoidCallback? onPreviewImage;
  final BoxFit? fit;
  CustomCacheImageWidget(
      {Key? key,
      required this.imageUrl,
      this.size = 45,
      this.placeHolder,
      this.isEnabled = true,
      this.isGradientBorder = false,
      this.onPickImage,
      this.radius,
      this.borderRadius,
      this.height,
      this.width,
      this.fit,
      this.onPreviewImage,
      this.isCircle = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderSize = isGradientBorder ? 2 : 0;

    // print(imageUrl);
    return SingleTapDetector(
      onTap: () {
        onPickImage?.call();
        onPreviewImage?.call();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 16.r),
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.black, // Set the border color
                //   width: 2.w, // Set the border width
                // ),
                borderRadius:
                    borderRadius ?? BorderRadius.circular(radius ?? 16.r),
              ),
              child: CachedNetworkImage(
                filterQuality: FilterQuality.high,
                // httpHeaders: {"Authorization": "Bearer ${_pref.authToken}"},
                imageUrl: imageUrl ?? "",
                fit: fit ?? BoxFit.cover,
                width: width ?? size - borderSize,
                height: height ?? size - borderSize,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: isCircle == false
                          ? BoxShape.rectangle
                          : BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider,
                          fit: fit ?? BoxFit.cover,
                          colorFilter: isEnabled
                              ? null
                              : const ColorFilter.mode(
                                  AppColors.grey400, BlendMode.hue)),
                    ),
                  );
                },
                placeholder: (context, url) => ShimmerWidget.rectangular(
                  width: width ?? size - borderSize,
                  height: height ?? size - borderSize,
                  // decoration: BoxDecoration(
                  //   borderRadius:
                  //       borderRadius ?? BorderRadius.circular(radius ?? 16.r),
                  // ),
                  // child: const Center(
                  //   child: CircularProgressIndicator(
                  //     strokeWidth: 4,
                  //     color:
                  //         AppColors.primaryColor, // Độ dày của đường vòng tròn
                  //   ),
                  // ),
                ),
                //     Image.asset(
                //   placeHolder ?? R.drawable.ic_no_image,
                //   fit: fit ?? BoxFit.fill,
                //   width: width ?? size - borderSize,
                //   height: height ?? size - borderSize,
                // ),
                errorWidget: (context, url, _) => Image.asset(
                  placeHolder ?? 'assets/icon/ic_no-pictures.png',
                  fit: fit ?? BoxFit.contain,
                  width: 40.w,
                  height: 30.h,
                ),
              ),
            ),
          ),
          // if is input infor page => remove this image widget (qoute: placeHolder == null)
          if (onPickImage != null && placeHolder == null)
            Image.asset('assets/icon/ic_add_image.png',
                width: 44.w, height: 44.h),
        ],
      ),
    );
  }
}
