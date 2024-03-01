import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/utils.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.isEnable = true,
    this.autoFocus = false,
    this.onChanged,
    this.isPassword = false,
    this.icon,
    this.errorText,
    this.labelText,
    this.hintText,
    this.inputFormatters,
    this.maxLines,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.readOnly = false,
    this.onTap,
    this.fillColor,
    this.onSubmitted,
    this.maxLength,
    this.isCounterText = false,
    this.fillBackground = false,
    this.suffixIcon,
    this.onPressDelete,
    this.titleText,
    this.require = false,
    this.isErrorEnable = false,
    this.suffixColor,
    this.borderColor,
    this.titleSize,
    this.titleWeight,
    this.borderErrorColor,
    this.borderFocusColor,
    this.borderDisableColor,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isEnable;
  final bool autoFocus;
  final bool require;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final FormFieldSetter<String>? onChanged;
  final bool isPassword;
  final String? titleText;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final int? maxLines;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final FormFieldSetter<String>? onSubmitted;
  final dynamic icon;
  final bool readOnly;
  final Function()? onTap;
  final Color? fillColor;
  final int? maxLength;
  final bool fillBackground;
  final bool? isCounterText;
  final String? suffixIcon;
  final VoidCallback? onPressDelete;
  final bool isErrorEnable;
  final Color? suffixColor;
  final Color? borderErrorColor;
  final Color? borderFocusColor;
  final Color? borderColor;
  final Color? borderDisableColor;
  @override
  final double? titleSize;
  final FontWeight? titleWeight;
  // ignore: library_private_types_in_public_api
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool _obscureText;
  bool _reachMaxLength = false;

  @override
  void initState() {
    super.initState();
    if (widget.maxLength != null) {
      _reachMaxLength = widget.controller.text.length >= widget.maxLength!;
    }
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: !Utils.isEmpty(widget.titleText),
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: RichText(
                text: TextSpan(
                    text: widget.titleText ?? "",
                    style: Theme.of(context).textTheme.buttonNormal.copyWith(
                        fontSize: widget.titleSize ?? 14.sp,
                        fontWeight: widget.titleWeight ?? FontWeight.w600,
                        color: widget.isEnable
                            ? const Color(0xFF4E4E4E)
                            : AppColors.dark5),
                    children: widget.require
                        ? <TextSpan>[
                            TextSpan(
                              text: " *",
                              style: Theme.of(context)
                                  .textTheme
                                  .body2Bold
                                  .copyWith(
                                      color: AppColors.darkger1, height: 1),
                            ),
                          ]
                        : []),
              ),
            )),
        Container(
          decoration: ShapeDecoration(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r))),
          child: TextField(
            enabled: widget.isEnable,
            autofocus: widget.autoFocus,
            focusNode: widget.focusNode,
            controller: widget.controller,
            obscureText: _obscureText,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            decoration: InputDecoration(
                counterText: widget.isCounterText! ? null : '',
                // filled: widget.fillBackground,
                filled: true,
                fillColor: widget.fillColor ??
                    (widget.isEnable ? AppColors.white : AppColors.dark12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                      width: 1,
                      color: widget.borderColor ?? const Color(0xFF4355F5)),
                ),
                disabledBorder: widget.fillBackground
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                            width: 1,
                            color:
                                widget.borderDisableColor ?? Color(0xFF4355F5)),
                      ),
                enabledBorder: widget.fillBackground
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                            width: 1,
                            color:
                                widget.borderColor ?? const Color(0xFF4355F5)),
                      ),
                focusedBorder: widget.fillBackground
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                            width: 1,
                            color:
                                widget.borderFocusColor ?? Color(0xFF4355F5)),
                      ),
                errorBorder: widget.fillBackground
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                            width: 1,
                            color:
                                widget.borderErrorColor ?? Color(0xFF4355F5)),
                      ),
                focusedErrorBorder: widget.fillBackground
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                            width: 1,
                            color:
                                widget.borderErrorColor ?? Color(0xFF4355F5)),
                      ),
                contentPadding: EdgeInsets.only(
                    left: widget.fillBackground ? 0.w : 16.w,
                    top: 14.h,
                    bottom: 14.h,
                    right: widget.isPassword ? 0 : 16.w),
                hintText: widget.hintText,
                errorText: widget.errorText,
                errorMaxLines: 1000,
                labelText: widget.labelText,
                prefixIcon: widget.icon == null
                    ? null
                    : (widget.icon is String
                        ? Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              widget.icon,
                              fit: BoxFit.fitHeight,
                              height: 5,
                            ),
                          )
                        : Icon(
                            widget.icon,
                            size: 24.h,
                          )),
                suffixIcon: /*widget.readOnly == true
                    ? null
                    : */
                    (widget.isPassword || widget.suffixIcon != null
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                if (widget.onPressDelete != null) {
                                  widget.controller.clear();
                                  widget.onPressDelete?.call();
                                  return;
                                }
                                if (widget.isPassword) {
                                  _obscureText = !_obscureText;
                                  return;
                                }
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 12.h,
                                  bottom: 12.h,
                                  left: 10.w,
                                  right: widget.fillBackground ? 0.w : 16.w),
                              // child: Image.asset(
                              //   (!Utils.isEmpty(widget.controller.text) &&
                              //           widget.onPressDelete != null)
                              //       ? Assets.icons.icDeleteField.path
                              //       : (widget.suffixIcon != null
                              //           ? (widget.suffixIcon ??
                              //               Assets.icons.icInvisibleEye.path)
                              //           : _obscureText
                              //               ? Assets.icons.icInvisibleEye.path
                              //               : Assets.icons.icVisibleEye.path),
                              //   height: 24.h,
                              //   width: 24.h,
                              //   color: widget.suffixColor,
                              // ),
                            ),
                          )
                        : null),
                suffixIconConstraints: BoxConstraints(
                  minHeight: 18.5.h,
                  minWidth: 18.5.w,
                ),
                labelStyle: Theme.of(context).textTheme.subTitle.copyWith(
                    color:
                        widget.isEnable ? AppColors.textDark : AppColors.gray),
                hintStyle: Theme.of(context).textTheme.subTitle.copyWith(
                      color: AppColors.greyText,
                    ),
                helperStyle:
                    Theme.of(context).textTheme.subTitleRegular.copyWith(
                          color: AppColors.lightGray,
                        ),
                counterStyle:
                    Theme.of(context).textTheme.subTitleRegular.copyWith(
                          color: _reachMaxLength
                              ? AppColors.darkRed
                              : AppColors.lightGray,
                        ),
                errorStyle: Theme.of(context).textTheme.textRegular.copyWith(
                      color: AppColors.darkRed,
                    )),
            keyboardType: widget.keyboardType,
            onChanged: (value) {
              setState(() {
                if (widget.maxLength != null) {
                  _reachMaxLength = value.length >= widget.maxLength!;
                }
                widget.onChanged?.call(value);
              });
            },
            onSubmitted: widget.onSubmitted,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            maxLength: widget.maxLength,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            style: widget.fillBackground
                ? Theme.of(context).textTheme.subTitle.copyWith(
                      color:
                          widget.isEnable ? AppColors.dark1 : AppColors.dark5,
                    )
                : Theme.of(context).textTheme.subTitle.copyWith(
                      color:
                          widget.isEnable ? AppColors.dark1 : AppColors.dark5,
                    ),
          ),
        ),
      ],
    );
  }
}
