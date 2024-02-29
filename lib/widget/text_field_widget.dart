import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/utils.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    this.rightWidget,
    this.suffixColor,
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
    this.style,
    this.require = false,
    this.onPressSuffix,
    this.isScroll,
    this.radius,
    this.hintStyle,
    this.isNotRequire = false,
    this.suffixWidget,
    this.colorRequired = true,
    this.isErrorEnable = false,
    this.isBorder = false,
    this.spacingBottom = true,
    this.contentError,
    this.iconColor,
    this.enableColorBorder,
    this.focusedColorBorder,
    this.showShadow = true,
    this.colorBorder,
    this.height,
    this.contentPadding,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isEnable;
  final bool autoFocus;
  final bool require;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final FormFieldSetter<String>? onChanged;
  final bool isPassword;
  final double? height;
  final String? titleText;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final bool colorRequired;
  final bool? isBorder;
  final Widget? rightWidget;
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
  final VoidCallback? onPressSuffix;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final EdgeInsets? isScroll;
  final double? radius;
  final Widget? suffixWidget;
  final bool isNotRequire;
  final bool isErrorEnable;
  final String? contentError;
  final bool? spacingBottom;
  final Color? iconColor;
  final Color? suffixColor;
  final Color? enableColorBorder;
  final Color? focusedColorBorder;
  final bool showShadow;
  final Color? colorBorder;
  final EdgeInsets? contentPadding;
  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool _obscureText;
  bool _reachMaxLength = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.maxLength != null) {
      _reachMaxLength = widget.controller.text.length >= widget.maxLength!;
    }
    _obscureText = widget.isPassword;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
                visible: !Utils.isEmpty(widget.titleText),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: RichText(
                    text: TextSpan(
                        text: widget.titleText ?? '',
                        style: widget.style ??
                            Theme.of(context).textTheme.text14W600.copyWith(
                                color: widget.isEnable
                                    ? (widget.isErrorEnable == true
                                        ? AppColors.red
                                        : AppColors.dark1)
                                    : AppColors.dark5),
                        children: widget.require
                            ? <TextSpan>[
                                TextSpan(
                                  text: ' *',
                                  style: widget.colorRequired
                                      ? Theme.of(context)
                                          .textTheme
                                          .body2Bold
                                          .copyWith(
                                              color: AppColors.darkger1,
                                              height: 1)
                                      : Theme.of(context)
                                          .textTheme
                                          .body2Bold
                                          .copyWith(height: 1),
                                ),
                              ]
                            : (widget.isNotRequire
                                ? [
                                    TextSpan(
                                        text: ' (Không bắt buộc)',
                                        style:
                                            Theme.of(context).textTheme.text12),
                                  ]
                                : [])),
                  ),
                )),
            Visibility(
              visible: !Utils.isEmpty(widget.rightWidget),
              child: Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: widget.rightWidget),
            )
          ],
        ),
        Container(
          height: widget.height,
          decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: !widget.showShadow
                  ? []
                  : widget.isBorder == true
                      ? []
                      : [
                          const BoxShadow(
                            color: AppColors.shadowColor,
                            blurRadius: 10,
                          )
                        ],
              borderRadius: BorderRadius.circular(widget.radius ?? 16.r),
              border:
                  Border.all(color: widget.colorBorder ?? Colors.transparent)),
          child: TextField(
            scrollPadding: widget.isScroll ?? EdgeInsets.zero,
            enabled: widget.isEnable,
            autofocus: widget.autoFocus,
            focusNode: _focusNode,
            controller: widget.controller,
            obscureText: _obscureText,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            decoration: InputDecoration(
                counterText: widget.isCounterText! ? null : '',
                filled: widget.fillBackground,
                fillColor: widget.fillColor ??
                    (widget.isEnable ? AppColors.white : AppColors.dark12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius ?? 16.r),
                    borderSide: BorderSide(
                      width: 1,
                      color: widget.colorBorder ?? AppColors.white,
                    )),
                disabledBorder: widget.fillBackground
                    ? null
                    : OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.radius ?? 16.r),
                        borderSide: const BorderSide(color: AppColors.white),
                      ),
                enabledBorder: widget.fillBackground
                    ? null
                    : OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.radius ?? 16.r),
                        borderSide: BorderSide(
                            color: widget.isErrorEnable
                                ? AppColors.dangerColor
                                : widget.enableColorBorder ?? AppColors.white),
                      ),
                focusedBorder: widget.fillBackground
                    ? null
                    : OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.radius ?? 16.r),
                        borderSide: BorderSide(
                            color: widget.isErrorEnable
                                ? AppColors.dangerColor
                                : widget.focusedColorBorder ??
                                    AppColors.newPrimary),
                      ),
                focusedErrorBorder: widget.fillBackground
                    ? null
                    : OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.radius ?? 16.r),
                        borderSide: const BorderSide(color: AppColors.white),
                      ),
                contentPadding: widget.contentPadding ??
                    EdgeInsets.only(
                        left: widget.fillBackground ? 16.w : 16.w,
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
                    widget.suffixWidget ??
                        (widget.isPassword ||
                                widget.suffixIcon != null ||
                                widget.suffixWidget != null
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (widget.onPressDelete != null) {
                                      widget.controller.clear();
                                      widget.onPressDelete?.call();
                                      return;
                                    }
                                    widget.onPressSuffix?.call();
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
                                      right:
                                          widget.fillBackground ? 0.w : 16.w),
                                  child: Image.asset(
                                    widget.suffixIcon ?? '',
                                    // (!Utils.isEmpty(widget.controller.text) &&
                                    //         widget.onPressDelete != null)
                                    //     ? R.drawable.ic_delete_field
                                    //     : (widget.suffixIcon != null
                                    //         ? (widget.suffixIcon ??
                                    //             R.drawable.ic_invisible_eye)
                                    //         : _obscureText
                                    //             ? R.drawable.ic_invisible_eye
                                    //             : R.drawable.ic_visible_eye),
                                    height: 24.h,
                                    width: 24.h,
                                    color: widget.iconColor,
                                  ),
                                ),
                              )
                            : null),
                suffixIconConstraints: BoxConstraints(
                  minHeight: 18.5.h,
                  minWidth: 18.5.w,
                ),
                labelStyle: widget.style ??
                    Theme.of(context).textTheme.subTitle.copyWith(
                        color: widget.isEnable
                            ? AppColors.textDark
                            : AppColors.gray),
                hintStyle: widget.hintStyle ??
                    Theme.of(context).textTheme.subTitle.copyWith(
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
        if (widget.spacingBottom ?? true) 8.verticalSpace,
        Visibility(
            visible:
                widget.isErrorEnable && !Utils.isEmpty(widget.contentError),
            child: Text(
              widget.contentError ?? '',
              style: Theme.of(context)
                  .textTheme
                  .subTitle12
                  .copyWith(color: AppColors.dangerColor),
              overflow: TextOverflow.visible,
            )),
      ],
    );
  }
}
