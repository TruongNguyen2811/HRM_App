import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrm/configuration/colors.dart';
import 'package:hrm/utils/custom_gradient.dart';
import 'package:hrm/utils/custom_theme.dart';
import 'package:hrm/utils/navigation_utils.dart';
import 'package:hrm/widget/button_widget.dart';

class NewPickerTimeWidget extends StatefulWidget {
  final String? titleButton;
  final String? title;
  final String initData;
  final Function(DateTime)? onSelectedTime;
  final String? firstTime;

  const NewPickerTimeWidget(
      {super.key,
      required this.initData,
      this.onSelectedTime,
      this.firstTime,
      this.titleButton,
      this.title});

  @override
  State<NewPickerTimeWidget> createState() => _NewPickerTimeWidgetState();
}

class _NewPickerTimeWidgetState extends State<NewPickerTimeWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.parse(widget.initData);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.r),
                  topLeft: Radius.circular(16.r))),
          child: Column(
            children: [
              14.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      child: InkWell(
                          onTap: () {
                            NavigationUtils.popDialog(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 24.w,
                          )),
                    ),
                    Center(
                      child: Text(
                        widget.title ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .labelHighLight
                            .copyWith(color: AppColors.neuturalText),
                      ),
                    ),
                  ],
                ),
              ),
              6.verticalSpace,
              const Divider(
                color: AppColors.dark3,
              ),
              SizedBox(
                height: 0.3.sh,
                child: CupertinoDatePicker(
                  use24hFormat: true,
                  backgroundColor:
                      CupertinoColors.systemBackground.resolveFrom(context),
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.parse(widget.initData),
                  onDateTimeChanged: (DateTime newDateTime) {
                    _selectedDate = newDateTime;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.dg),
                child: ButtonWidget(
                    gradient: mainGradientPrimary(),
                    title: widget.titleButton ?? '',
                    onPressed: () {
                      widget.onSelectedTime?.call(_selectedDate);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
